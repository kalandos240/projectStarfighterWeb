const fs = require('fs');
const port = process.env.CDP_PORT;
const endpoint = `http://127.0.0.1:${port}/json/list`;
const mission = process.env.MISSION;
const out = process.env.OUT;
const targetPrefix = `http://127.0.0.1:8765/index.html?promo=${mission}`;
const sleep = ms => new Promise(r => setTimeout(r, ms));

async function findTarget() {
  for (let i = 0; i < 900; i++) {
    try {
      const a = await (await fetch(endpoint)).json();
      const t = a.find(x => x.type === 'page' && x.url.startsWith(targetPrefix));
      if (t?.webSocketDebuggerUrl) return t;
    } catch (_) {}
    await sleep(100);
  }
  throw new Error('target timeout ' + mission);
}

async function main() {
  const t = await findTarget();
  const ws = new WebSocket(t.webSocketDebuggerUrl);
  await new Promise((resolve, reject) => { ws.onopen = resolve; ws.onerror = reject; });
  let id = 0;
  const pending = new Map();
  ws.onmessage = e => {
    const m = JSON.parse(e.data);
    if (m.id && pending.has(m.id)) {
      const p = pending.get(m.id);
      pending.delete(m.id);
      m.error ? p.reject(new Error(JSON.stringify(m.error))) : p.resolve(m.result || {});
    }
  };
  function send(method, params = {}) {
    return new Promise((resolve, reject) => {
      const n = ++id;
      pending.set(n, { resolve, reject });
      ws.send(JSON.stringify({ id: n, method, params }));
    });
  }
  async function ev(expr) {
    const r = await send('Runtime.evaluate', { expression: expr, returnByValue: true });
    return r.result?.value;
  }
  async function wait(expr, ms = 120000) {
    const end = Date.now() + ms;
    while (Date.now() < end) {
      try { if (await ev(expr)) return; } catch (_) {}
      await sleep(150);
    }
    throw new Error('wait timeout ' + mission);
  }
  async function key(type, code, keyValue, vk, text) {
    await send('Input.dispatchKeyEvent', {
      type, code, key: keyValue,
      windowsVirtualKeyCode: vk,
      nativeVirtualKeyCode: vk,
      ...(text ? { text } : {})
    });
  }

  await send('Runtime.enable');
  await send('Page.enable');
  await send('Emulation.setDeviceMetricsOverride', {
    width: 1280,
    height: 720,
    deviceScaleFactor: 1,
    mobile: false,
    screenWidth: 1280,
    screenHeight: 720
  });
  await wait(`window.innerWidth===1280 && window.innerHeight===720`);
  await wait(`document.documentElement?.getAttribute('data-starfighter-runtime-initialized')==='1'`);
  await wait(`globalThis.starfighterGameplayDesired===true`);
  await sleep(700);
  await key('keyDown', 'Space', ' ', 32, ' ');
  await sleep(100);
  await key('keyUp', 'Space', ' ', 32);
  await sleep(1800);

  const patterns = {
    HAIL: ['ArrowRight', 'Space'],
    CERADSE: ['ArrowUp', 'Space'],
    JOLDAR: ['ArrowDown', 'Space'],
    MOEBO: ['ArrowRight', 'Control'],
    NEROD: ['ArrowLeft', 'Space'],
    ODEON: ['ArrowUp', 'Control'],
    JUPITER: ['ArrowRight', 'Space'],
    EARTH: ['ArrowDown', 'Space']
  };
  const map = {
    ArrowRight: ['ArrowRight', 'ArrowRight', 39],
    ArrowLeft: ['ArrowLeft', 'ArrowLeft', 37],
    ArrowUp: ['ArrowUp', 'ArrowUp', 38],
    ArrowDown: ['ArrowDown', 'ArrowDown', 40],
    Space: ['Space', ' ', 32, ' '],
    Control: ['ControlLeft', 'Control', 17]
  };

  for (const k of patterns[mission]) {
    const x = map[k];
    await key('keyDown', x[0], x[1], x[2], x[3]);
  }
  await sleep(900);
  const shot = await send('Page.captureScreenshot', { format: 'png', captureBeyondViewport: false });
  fs.writeFileSync(out, Buffer.from(shot.data, 'base64'));
  for (const k of [...patterns[mission]].reverse()) {
    const x = map[k];
    await key('keyUp', x[0], x[1], x[2]);
  }
  ws.close();
}

main().catch(e => { console.error(e); process.exit(1); });
