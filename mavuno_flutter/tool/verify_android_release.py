#!/usr/bin/env python3
"""Check a signed universal Mavuno APK before publishing it."""

from __future__ import annotations

import hashlib
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path
from zipfile import BadZipFile, ZipFile


PACKAGE_ID = "com.mavuno.farm"
PRODUCTION_API = b"https://mavuno.api.serverpod.space/"
REQUIRED_LIBRARIES = {"libapp.so", "libflutter.so"}


def fail(message: str) -> None:
    raise SystemExit(f"ERROR: {message}")


def sdk_tool(name: str) -> str:
    sdk = os.environ.get("ANDROID_HOME") or os.environ.get("ANDROID_SDK_ROOT")
    if not sdk:
        fail("set ANDROID_HOME or ANDROID_SDK_ROOT to the Android SDK")

    candidates = sorted((Path(sdk) / "build-tools").glob("*/" + name))
    if not candidates:
        fail(f"could not find {name} under {sdk}/build-tools")
    return str(candidates[-1])


def main() -> None:
    if len(sys.argv) != 2:
        fail(f"usage: {Path(sys.argv[0]).name} <release.apk>")

    apk = Path(sys.argv[1]).resolve()
    if not apk.is_file():
        fail(f"APK not found: {apk}")

    try:
        with ZipFile(apk) as archive:
            damaged_entry = archive.testzip()
            if damaged_entry:
                fail(f"corrupt ZIP entry: {damaged_entry}")

            names = set(archive.namelist())
            abis = sorted(
                name.split("/")[1]
                for name in names
                if name.startswith("lib/") and len(name.split("/")) > 2
            )
            abis = sorted(set(abis))
            if not abis:
                fail("APK contains no native ABI libraries")

            for abi in abis:
                libraries = {
                    name.rsplit("/", 1)[-1]
                    for name in names
                    if name.startswith(f"lib/{abi}/")
                }
                missing = REQUIRED_LIBRARIES - libraries
                if missing:
                    fail(f"{abi} is advertised but missing {', '.join(sorted(missing))}")
                app_library = archive.read(f"lib/{abi}/libapp.so")
                if PRODUCTION_API not in app_library:
                    fail(f"production API URL is missing from the {abi} Flutter app")
    except (BadZipFile, OSError) as error:
        fail(f"cannot read APK archive: {error}")

    aapt = sdk_tool("aapt")
    badging = subprocess.run(
        [aapt, "dump", "badging", str(apk)],
        check=True,
        capture_output=True,
        text=True,
    ).stdout
    package = re.search(
        r"^package: name='([^']+)' versionCode='([^']+)' versionName='([^']+)'",
        badging,
        re.MULTILINE,
    )
    min_sdk = re.search(r"^sdkVersion:'([^']+)'", badging, re.MULTILINE)
    target_sdk = re.search(r"^targetSdkVersion:'([^']+)'", badging, re.MULTILINE)
    if not package or package.group(1) != PACKAGE_ID:
        fail(f"APK package ID is not {PACKAGE_ID}")
    if not min_sdk or int(min_sdk.group(1)) > 24:
        fail("APK minimum SDK is above the supported API 24 baseline")
    if not target_sdk:
        fail("APK target SDK could not be read")

    signature = subprocess.run(
        [sdk_tool("apksigner"), "verify", "--verbose", str(apk)],
        check=True,
        capture_output=True,
        text=True,
    ).stdout
    if "Verifies" not in signature:
        fail("apksigner did not verify this APK")

    digest = hashlib.sha256(apk.read_bytes()).hexdigest()
    print(f"APK: {apk}")
    print(f"Size: {apk.stat().st_size:,} bytes")
    print(f"SHA-256: {digest}")
    print(f"Package: {package.group(1)} {package.group(3)}+{package.group(2)}")
    print(f"SDK: min {min_sdk.group(1)}, target {target_sdk.group(1)}")
    print(f"ABIs: {', '.join(abis)}")
    print("Signature: verified")
    print("Production API: verified in each ABI's Flutter app library")


if __name__ == "__main__":
    main()
