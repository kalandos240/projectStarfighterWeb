const canvas = document.getElementById('canvas');
const loading = document.getElementById('loading');

document.addEventListener('contextmenu', function (event) {
  if (event.target === canvas || canvas.contains(event.target)) event.preventDefault();
});

const starfighterControlKeys = new Set([
  'ArrowUp', 'ArrowDown', 'ArrowLeft', 'ArrowRight',
  'KeyW', 'KeyA', 'KeyS', 'KeyD', 'KeyE', 'KeyJ', 'KeyK',
  'Space', 'ControlLeft', 'ControlRight', 'ShiftLeft', 'ShiftRight', 'Escape'
]);

window.addEventListener('keydown', function (event) {
  if (starfighterControlKeys.has(event.code)) event.preventDefault();
}, { passive: false });

window.addEventListener('keyup', function (event) {
  if (starfighterControlKeys.has(event.code)) event.preventDefault();
}, { passive: false });

canvas.addEventListener('mousedown', function () {
  canvas.focus();
});

function setStarfighterPlatformPaused(paused) {
  if (typeof globalThis.starfighterSetPlatformPaused === 'function') {
    globalThis.starfighterSetPlatformPaused(paused);
  } else {
    globalThis.starfighterPlatformPaused = !!paused;
  }
}

document.addEventListener('visibilitychange', function () {
  setStarfighterPlatformPaused(document.hidden);
});
window.addEventListener('blur', function () {
  setStarfighterPlatformPaused(true);
});
window.addEventListener('focus', function () {
  if (!document.hidden) setStarfighterPlatformPaused(false);
});
window.addEventListener('pagehide', function () {
  setStarfighterPlatformPaused(true);
});

globalThis.starfighterSessionStartedAt = Date.now();
globalThis.starfighterLastInterstitialAt = 0;
globalThis.starfighterMissionEnded = function () {
  const sdk = globalThis.starfighterYsdk;
  const now = Date.now();
  if (!sdk || !sdk.adv || typeof sdk.adv.showFullscreenAdv !== 'function') return;
  if (now - globalThis.starfighterSessionStartedAt < 60000) return;
  if (now - globalThis.starfighterLastInterstitialAt < 120000) return;

  globalThis.starfighterLastInterstitialAt = now;
  setStarfighterPlatformPaused(true);
  try {
    sdk.adv.showFullscreenAdv({
      callbacks: {
        onOpen: function () {
          setStarfighterPlatformPaused(true);
          document.documentElement.setAttribute('data-starfighter-ad-open', '1');
        },
        onClose: function (wasShown) {
          setStarfighterPlatformPaused(false);
          document.documentElement.setAttribute('data-starfighter-ad-closed', wasShown ? '1' : '0');
          canvas.focus();
        },
        onError: function (err) {
          setStarfighterPlatformPaused(false);
          console.warn('Yandex fullscreen ad failed:', err);
          canvas.focus();
        }
      }
    });
  } catch (err) {
    setStarfighterPlatformPaused(false);
    console.warn('Could not request Yandex fullscreen ad:', err);
  }
};

var Module = globalThis.Module = {
  canvas: canvas,
  onRuntimeInitialized: function () {
    loading.classList.add('hidden');
    canvas.focus();
    document.documentElement.setAttribute('data-starfighter-shell-ready', '1');
  }
};
