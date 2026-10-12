/// The simulator's single page. Self-contained: no external scripts, fonts
/// or styles, so it works offline. Colours follow the Mavuno app theme.
const simulatorPage = r'''<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Mavuno · Simulated LMS</title>
<style>
  :root {
    --paper: #F6F6F1; --surface: #FFFFFF; --line: #E7E8E0; --soft: #E8EDE4;
    --green: #315D42; --ink: #203B2D; --muted: #777A70; --clay: #B87943;
    --flag: #B85B32; --flag-bg: #F8E9E1; --ok: #39724C; --ok-bg: #E5EFE6;
    --amber: #AA7A22; --error: #AE4036; --error-bg: #FCEBE8;
  }
  * { box-sizing: border-box; }
  body { margin: 0; background: var(--paper); color: var(--ink);
    font: 14px/1.45 system-ui, -apple-system, "Segoe UI", Roboto, sans-serif; }
  header { background: var(--ink); color: #fff; padding: 14px 28px;
    display: flex; align-items: center; gap: 14px; flex-wrap: wrap; }
  .brand { font-weight: 800; font-size: 18px; letter-spacing: .2px; }
  .pill { font-size: 11px; font-weight: 700; letter-spacing: 1px; padding: 4px 10px;
    border-radius: 20px; background: rgba(255,255,255,.14); }
  .connection { margin-left: auto; font-size: 13px; color: #DCE5DD;
    display: flex; align-items: center; gap: 8px; }
  .dot { width: 9px; height: 9px; border-radius: 50%; background: #7FC48F; flex: none; }
  .dot.off { background: #E57B6E; }
  main { max-width: 1180px; margin: 0 auto; padding: 26px 24px 48px; }
  .card { background: var(--surface); border: 1px solid var(--line);
    border-radius: 16px; padding: 20px; }
  .eyebrow { font-size: 10px; font-weight: 700; letter-spacing: 1.1px; color: var(--muted); }
  h2 { font-size: 16px; margin: 0 0 12px; }
  .hero { display: grid; grid-template-columns: 1.4fr 1fr; gap: 24px; align-items: center; }
  .clock { font-size: 30px; font-weight: 800; line-height: 1.15; margin: 6px 0 4px; }
  .sub { color: var(--muted); }
  .timeline { display: grid; grid-template-columns: repeat(3, 1fr); gap: 6px; margin-top: 16px; }
  .slot { border-radius: 10px; padding: 8px 10px; background: #F5F6F2; color: var(--muted);
    font-size: 12px; border: 1px solid transparent; }
  .slot b { display: block; color: var(--ink); font-size: 13px; }
  .slot.done { background: var(--soft); }
  .slot.next { border-color: var(--green); background: #fff; }
  .slot.next b { color: var(--green); }
  .controls { display: flex; flex-direction: column; gap: 12px; }
  button { font: inherit; cursor: pointer; border-radius: 12px; border: 0; }
  button:disabled { opacity: .55; cursor: default; }
  .primary { background: var(--green); color: #fff; font-weight: 700; font-size: 16px;
    padding: 15px 20px; display: flex; align-items: center; justify-content: center; gap: 10px; }
  .primary.preview { background: var(--clay); }
  .text { background: none; color: var(--green); font-weight: 600; padding: 6px 0; text-align: left; }
  .outline { background: #fff; color: var(--green); border: 1px solid #9EAF9E;
    font-weight: 600; padding: 9px 16px; }
  .toggle { display: flex; gap: 12px; align-items: flex-start; cursor: pointer; }
  .toggle input { display: none; }
  .switch { width: 40px; height: 24px; border-radius: 12px; background: #CDD2C8;
    position: relative; flex: none; transition: background .15s; margin-top: 1px; }
  .switch::after { content: ""; position: absolute; top: 3px; left: 3px; width: 18px; height: 18px;
    border-radius: 50%; background: #fff; transition: left .15s; }
  .toggle input:checked + .switch { background: var(--clay); }
  .toggle input:checked + .switch::after { left: 19px; }
  .toggle small { display: block; color: var(--muted); }
  .status { border-radius: 10px; padding: 10px 12px; font-size: 13px; display: none; }
  .status.show { display: block; }
  .status.ok { background: var(--ok-bg); color: #24502F; }
  .status.info { background: #F7EEDF; color: #7A5420; }
  .status.error { background: var(--error-bg); color: var(--error); }
  .spinner { width: 16px; height: 16px; border-radius: 50%; border: 2px solid rgba(255,255,255,.4);
    border-top-color: #fff; animation: spin .8s linear infinite; display: none; }
  .busy .spinner { display: inline-block; }
  @keyframes spin { to { transform: rotate(360deg); } }
  .section { margin-top: 22px; }
  .cameras { display: grid; grid-template-columns: repeat(3, 1fr); gap: 14px; }
  .camera { padding: 16px; }
  .camera-head { display: flex; align-items: center; gap: 8px; }
  .camera-head strong { font-size: 15px; }
  .live { margin-left: auto; font-size: 11px; font-weight: 700; color: var(--ok);
    display: flex; align-items: center; gap: 5px; }
  .live .dot { width: 7px; height: 7px; }
  .zone { color: var(--muted); font-size: 13px; }
  .feed { margin-top: 12px; border-top: 1px solid var(--line); padding-top: 10px; min-height: 64px; }
  .feed div { display: flex; gap: 8px; font-size: 13px; padding: 2px 0; }
  .feed time { color: var(--muted); font-variant-numeric: tabular-nums; }
  .stat { font-size: 12px; color: var(--muted); margin-top: 8px; }
  .columns { display: grid; grid-template-columns: 1.65fr 1fr; gap: 18px; align-items: start; }
  table { width: 100%; border-collapse: collapse; }
  th { text-align: left; font-size: 10px; letter-spacing: .8px; color: var(--muted);
    font-weight: 700; padding: 0 8px 8px; }
  td { padding: 10px 8px; border-top: 1px solid var(--line); vertical-align: middle; }
  .animal { display: flex; align-items: center; gap: 10px; }
  .emoji { width: 36px; height: 36px; border-radius: 9px; background: var(--soft);
    display: grid; place-items: center; font-size: 19px; flex: none; }
  .animal small { display: block; color: var(--muted); }
  select, input[type=number] { font: inherit; border: 1px solid #E1E2D9; border-radius: 10px;
    padding: 7px 9px; background: #FFFEFB; color: var(--ink); }
  select { width: 100%; max-width: 190px; }
  input[type=number] { width: 78px; }
  .score { display: inline-block; min-width: 34px; text-align: center; font-weight: 800;
    border-radius: 20px; padding: 3px 8px; font-size: 12px; background: var(--ok-bg); color: var(--ok); }
  .score.flag { background: var(--flag-bg); color: var(--flag); }
  .score.none { background: #F1F2EE; color: var(--muted); }
  .muted { color: var(--muted); }
  .note { font-size: 12px; color: var(--muted); margin-top: 12px; }
  .ref-row { display: grid; grid-template-columns: 76px 1fr 1fr; gap: 10px; align-items: end;
    padding: 10px 0; border-top: 1px solid var(--line); }
  .ref-row:first-of-type { border-top: 0; }
  .ref-row label { font-size: 11px; color: var(--muted); display: block; }
  .ref-row .per { font-size: 11px; color: var(--muted); }
  .runs details { border-top: 1px solid var(--line); padding: 12px 0; }
  .runs details:first-child { border-top: 0; }
  summary { cursor: pointer; display: flex; align-items: center; gap: 10px; flex-wrap: wrap;
    list-style: none; font-weight: 700; }
  summary::-webkit-details-marker { display: none; }
  summary::before { content: "▸"; color: var(--muted); }
  details[open] summary::before { content: "▾"; }
  .badge { font-size: 11px; font-weight: 700; border-radius: 20px; padding: 3px 9px; }
  .badge.posted { background: var(--ok-bg); color: var(--ok); }
  .badge.dry { background: #F7EEDF; color: #7A5420; }
  .badge.failed { background: var(--error-bg); color: var(--error); }
  .when { margin-left: auto; font-weight: 400; color: var(--muted); font-size: 12px; }
  .reading { display: grid; grid-template-columns: 150px 120px 1fr; gap: 12px;
    padding: 10px 0 10px 18px; border-top: 1px dashed var(--line); font-size: 13px; }
  .reading:first-of-type { border-top: 0; }
  .reading .notes { color: #3E4A40; }
  .failure { color: var(--error); font-size: 13px; padding: 6px 0 0 18px; }
  .empty { color: var(--muted); padding: 18px 0; text-align: center; }
  footer { text-align: center; color: var(--muted); font-size: 12px; margin-top: 30px; }
  @media (max-width: 900px) {
    .hero, .columns { grid-template-columns: 1fr; }
    .cameras { grid-template-columns: 1fr; }
    .reading { grid-template-columns: 1fr; gap: 4px; }
    header, main { padding-left: 16px; padding-right: 16px; }
  }
</style>
</head>
<body>
<header>
  <span class="brand">Mavuno LMS</span>
  <span class="pill">SIMULATED</span>
  <span class="connection" id="connection"><span class="dot off"></span>Connecting…</span>
</header>
<main>
  <section class="card hero">
    <div>
      <div class="eyebrow">FARM CLOCK · NEXT WINDOW</div>
      <div class="clock" id="clock">—</div>
      <div class="sub" id="clockSub">Each report covers 4 hours of camera tracking.</div>
      <div class="timeline" id="timeline"></div>
    </div>
    <div class="controls">
      <button class="primary" id="generate"><span class="spinner"></span><span id="generateLabel">Generate report</span></button>
      <label class="toggle">
        <input type="checkbox" id="dryRun">
        <span class="switch"></span>
        <span><b>Dry run</b><small>Preview the next window without posting to Mavuno or moving the clock.</small></span>
      </label>
      <div class="status" id="status"></div>
      <button class="text" id="reset">Reset clock to Day 1, 06:00</button>
    </div>
  </section>

  <section class="section">
    <div class="eyebrow" style="margin-bottom:10px">CAMERAS · LAST WINDOW</div>
    <div class="cameras" id="cameras"></div>
  </section>

  <section class="section columns">
    <div class="card">
      <h2>Herd</h2>
      <div id="herd"></div>
      <div class="note" id="notMonitored"></div>
    </div>
    <div class="card">
      <h2>Reference values</h2>
      <div class="muted" style="font-size:13px">Time per 12-hour day that scores 10. Each 4-hour window uses a third.</div>
      <form id="references"></form>
      <div class="note">Mavuno Sentinel flags appetite or activity scores of 4 or below.</div>
    </div>
  </section>

  <section class="section card">
    <h2>Report log</h2>
    <div class="runs" id="runs"></div>
  </section>

  <footer>Synthetic observations for local development, tagged “Simulated LMS” in Mavuno.<br>
  Farm Sentinel provides early warnings and decision support, not veterinary diagnosis.</footer>
</main>
<script>
const $ = (id) => document.getElementById(id);
const esc = (value) => String(value ?? '').replace(/[&<>"']/g, (c) =>
  ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[c]);
const emoji = { cattle: '🐄', sheep: '🐑', goats: '🐐' };
const slots = ['06:00–10:00', '10:00–14:00', '14:00–18:00'];
let state = null;
let referencesShown = false;

async function api(path, body) {
  const options = body === undefined ? {} : {
    method: 'POST',
    headers: { 'content-type': 'application/json', 'x-mavuno-lms': '1' },
    body: JSON.stringify(body),
  };
  const response = await fetch(path, options);
  const data = await response.json().catch(() => ({}));
  if (data.state) render(data.state);
  if (!response.ok) throw new Error(data.error || 'The simulator could not complete this request.');
  return data;
}

function showStatus(kind, message) {
  const status = $('status');
  status.className = `status show ${kind}`;
  status.textContent = message;
}

function render(next) {
  state = next;
  const connection = $('connection');
  if (state.herdError) {
    connection.innerHTML = `<span class="dot off"></span>${esc(state.herdError)}`;
  } else if (state.farm) {
    connection.innerHTML = `<span class="dot"></span>Connected · ${esc(state.farm.name)} · ${esc(state.account)}`;
  }

  const clock = state.nextWindow;
  $('clock').textContent = `Day ${clock.day} · ${clock.timeRange}`;
  $('clockSub').textContent = `${clock.period} window · the next report covers 4 hours of camera tracking.`;
  const slot = clock.index % 3;
  $('timeline').innerHTML = slots.map((range, i) =>
    `<div class="slot ${i < slot ? 'done' : i === slot ? 'next' : ''}"><b>${range}</b>${
      i < slot ? 'Reported' : i === slot ? 'Next' : 'Later today'}</div>`).join('');

  $('dryRun').checked = state.dryRun;
  const generate = $('generate');
  generate.classList.toggle('preview', state.dryRun);
  $('generateLabel').textContent = state.dryRun ? 'Preview report' : 'Generate report';
  generate.disabled = state.busy || !state.farm;

  renderCameras();
  renderHerd();
  if (!referencesShown) renderReferences();
  renderRuns();
}

function renderCameras() {
  const run = state.latestRun;
  $('cameras').innerHTML = state.cameras.map((camera) => {
    const seen = run?.cameras.find((c) => c.id === camera.id);
    const events = seen?.events ?? [];
    const feed = !run ? '<span class="muted">Waiting for the first report.</span>'
      : events.length === 0 ? '<span class="muted">No unusual behaviour in this zone.</span>'
      : events.map((e) => `<div><time>${esc(e.time)}</time><span><b>${esc(e.tag)}</b> · ${esc(e.typeLabel)}</span></div>`).join('');
    const stat = seen ? `${seen.animalsSeen} animals · ${seen.animalMinutes} animal-minutes tracked · ${esc(run.window.label)}` : '';
    return `<div class="card camera">
      <div class="camera-head"><strong>${esc(camera.label)}</strong><span class="live"><span class="dot"></span>LIVE</span></div>
      <div class="zone">${esc(camera.zone)}</div>
      <div class="feed">${feed}</div>
      <div class="stat">${stat}</div>
    </div>`;
  }).join('');
}

function scoreBadge(value) {
  if (value === undefined || value === null) return '<span class="score none">—</span>';
  return `<span class="score ${value <= 4 ? 'flag' : ''}" title="${value <= 4 ? 'Sentinel will flag this' : 'Within normal range'}">${value}</span>`;
}

function renderHerd() {
  if (!state.farm) {
    $('herd').innerHTML = `<div class="empty">${esc(state.herdError || 'Loading the herd from Mavuno…')}</div>`;
    $('notMonitored').textContent = '';
    return;
  }
  if (state.herd.length === 0) {
    $('herd').innerHTML = '<div class="empty">No animals to monitor yet. Add active cattle, sheep or goats in Mavuno.</div>';
  } else {
    const latest = new Map((state.latestRun?.readings ?? []).map((r) => [r.animal.id, r]));
    $('herd').innerHTML = `<table><thead><tr><th>ANIMAL</th><th>CONDITION</th><th>APPETITE</th><th>ACTIVITY</th><th>EVENTS</th></tr></thead><tbody>${
      state.herd.map((animal) => {
        const reading = latest.get(animal.id);
        const options = [`<option value="auto">Auto · ${esc(animal.autoCondition)}</option>`]
          .concat(state.conditions
            .filter((c) => c.id !== 'inHeat' || animal.isFemale)
            .map((c) => `<option value="${c.id}">${esc(c.label)}</option>`)).join('');
        return `<tr>
          <td><div class="animal"><span class="emoji">${emoji[animal.species] ?? '🐾'}</span>
            <span><b>${esc(animal.name || animal.tag)}</b><small>${esc(animal.name ? animal.tag + ' · ' : '')}${esc(animal.speciesLabel)}</small></span></div></td>
          <td><select data-animal="${animal.id}" aria-label="Condition of ${esc(animal.tag)}">${options}</select></td>
          <td>${scoreBadge(reading?.appetiteScore)}</td>
          <td>${scoreBadge(reading?.activityScore)}</td>
          <td>${reading ? reading.events.length : '<span class="muted">—</span>'}</td>
        </tr>`;
      }).join('')}</tbody></table>`;
    document.querySelectorAll('select[data-animal]').forEach((select) => {
      const animal = state.herd.find((a) => String(a.id) === select.dataset.animal);
      select.value = animal.conditionSetting;
      select.addEventListener('change', () => setCondition(animal, select.value));
    });
  }
  $('notMonitored').textContent = state.notMonitored.length
    ? `Not monitored: ${state.notMonitored.join(' · ')}` : '';
}

function renderReferences() {
  referencesShown = true;
  const species = [['cattle', 'Cattle'], ['sheep', 'Sheep'], ['goats', 'Goats']];
  const { min, max } = state.referenceLimits;
  $('references').innerHTML = species.map(([id, label]) => {
    const ref = state.references[id];
    return `<div class="ref-row">
      <b>${emoji[id]} ${label}</b>
      <div><label>Feeding h/day</label><input type="number" step="0.5" min="${min}" max="${max}" name="${id}.feedingHoursPerDay" value="${ref.feedingHoursPerDay}">
        <div class="per">${ref.feedingMinutesPerWindow} min per window</div></div>
      <div><label>Active h/day</label><input type="number" step="0.5" min="${min}" max="${max}" name="${id}.activeHoursPerDay" value="${ref.activeHoursPerDay}">
        <div class="per">${ref.activeMinutesPerWindow} min per window</div></div>
    </div>`;
  }).join('') + '<div style="margin-top:12px"><button class="outline" type="submit">Save reference values</button></div>';
}

function renderRuns() {
  if (state.runs.length === 0) {
    $('runs').innerHTML = '<div class="empty">No reports yet. Generate one to see what the cameras saw.</div>';
    return;
  }
  $('runs').innerHTML = state.runs.map((run, index) => {
    const badges = run.dryRun ? '<span class="badge dry">Dry run · not posted</span>'
      : `<span class="badge posted">Posted ${run.posted} to Mavuno</span>${
        run.failures.length ? `<span class="badge failed">${run.failures.length} failed</span>` : ''}`;
    const when = new Date(run.recordedAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', second: '2-digit' });
    const readings = run.readings.map((r) => `<div class="reading">
        <div><b>${esc(r.animal.tag)}</b><br><span class="muted">${esc(r.conditionLabel)}${r.conditionOverridden ? ' (set)' : ''}</span></div>
        <div>Appetite ${scoreBadge(r.appetiteScore)}<br>Activity ${scoreBadge(r.activityScore)}</div>
        <div class="notes">${esc(r.notes)}</div>
      </div>`).join('');
    const failures = run.failures.map((f) => `<div class="failure">${esc(f)}</div>`).join('');
    return `<details ${index === 0 ? 'open' : ''}>
      <summary>${esc(run.window.label)} ${badges}<span class="when">${when}</span></summary>
      ${failures}${readings}
    </details>`;
  }).join('');
}

async function refresh() {
  try { render(await api('/api/state')); }
  catch (error) { showStatus('error', error.message); }
}

async function setCondition(animal, condition) {
  try {
    await api('/api/conditions', { animalId: animal.id, condition });
    showStatus('info', condition === 'auto'
      ? `${animal.tag} follows the automatic schedule again.`
      : `${animal.tag} will behave as “${state.conditions.find((c) => c.id === condition).label}” from the next report.`);
  } catch (error) { showStatus('error', error.message); }
}

$('generate').addEventListener('click', async () => {
  const button = $('generate');
  button.disabled = true;
  button.classList.add('busy');
  $('generateLabel').textContent = 'Tracking the herd…';
  try {
    const { run } = await api('/api/generate', {});
    if (run.dryRun) {
      showStatus('info', `Preview of ${run.window.label}. Nothing was posted and the clock did not move.`);
    } else if (run.failures.length) {
      showStatus('error', `Posted ${run.posted} of ${run.readings.length} observations for ${run.window.label}. ${run.failures[0]}`);
    } else {
      showStatus('ok', `Posted ${run.posted} observations to Mavuno for ${run.window.label}. Sentinel has re-assessed each animal.`);
    }
  } catch (error) {
    showStatus('error', error.message);
  } finally {
    button.classList.remove('busy');
    if (state) render(state);
  }
});

$('dryRun').addEventListener('change', async (event) => {
  try { await api('/api/settings', { dryRun: event.target.checked }); }
  catch (error) { showStatus('error', error.message); }
});

$('reset').addEventListener('click', async () => {
  if (!confirm('Start the farm clock again from Day 1, 06:00? Observations already in Mavuno stay as they are.')) return;
  try {
    await api('/api/clock/reset', {});
    showStatus('info', 'Farm clock reset to Day 1, 06:00.');
  } catch (error) { showStatus('error', error.message); }
});

$('references').addEventListener('submit', async (event) => {
  event.preventDefault();
  const references = {};
  for (const input of event.target.querySelectorAll('input')) {
    const [species, field] = input.name.split('.');
    (references[species] ??= {})[field] = Number(input.value);
  }
  try {
    await api('/api/settings', { references });
    renderReferences();
    showStatus('ok', 'Reference values saved. They apply from the next report.');
  } catch (error) { showStatus('error', error.message); }
});

document.addEventListener('visibilitychange', () => { if (!document.hidden) refresh(); });
refresh();
</script>
</body>
</html>
''';
