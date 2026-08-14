from pathlib import Path

p = Path('upstream/src/Starfighter.c')
s = p.read_text()
needle = '\tgame_init();\n\n\twhile (1)\n'
lines = [
    '\tgame_init();',
    '',
    '\tconst char *promoMission = NULL;',
    '\tfor (int i = 1; i < argc; i++)',
    '\t{',
    '\t\tif (strncmp(argv[i], "--promo=", 8) == 0)',
    '\t\t\tpromoMission = argv[i] + 8;',
    '\t}',
    '',
    '\tif (promoMission != NULL)',
    '\t{',
    '\t\tsection = 2;',
    '\t\tgame.stationedPlanet = 0;',
    '\t\tgame.destinationPlanet = 0;',
    '\t\tgame.hasWingMate1 = 1;',
    '\t\tgame.hasWingMate2 = 1;',
    '\t\tengine.cheat = 1;',
    '\t\tengine.cheatShield = 1;',
    '\t\tengine.cheatAmmo = 1;',
    '\t\tengine.cheatTime = 1;',
    '',
    '\t\tif (strcmp(promoMission, "HAIL") == 0) { game.system = SYSTEM_SPIRIT; game.area = MISN_HAIL; }',
    '\t\telse if (strcmp(promoMission, "CERADSE") == 0) { game.system = SYSTEM_SPIRIT; game.area = MISN_CERADSE; }',
    '\t\telse if (strcmp(promoMission, "JOLDAR") == 0) { game.system = SYSTEM_SPIRIT; game.area = MISN_JOLDAR; }',
    '\t\telse if (strcmp(promoMission, "MOEBO") == 0) { game.system = SYSTEM_SPIRIT; game.area = MISN_MOEBO; }',
    '\t\telse if (strcmp(promoMission, "NEROD") == 0) { game.system = SYSTEM_EYANANTH; game.area = MISN_NEROD; }',
    '\t\telse if (strcmp(promoMission, "ODEON") == 0) { game.system = SYSTEM_MORDOR; game.area = MISN_ODEON; }',
    '\t\telse if (strcmp(promoMission, "JUPITER") == 0) { game.system = SYSTEM_SOL; game.area = MISN_JUPITER; }',
    '\t\telse if (strcmp(promoMission, "EARTH") == 0) { game.system = SYSTEM_SOL; game.area = MISN_EARTH; }',
    '\t\telse { game.system = SYSTEM_SPIRIT; game.area = MISN_HAIL; }',
    '',
    '\t\tintermission_initPlanets(game.system);',
    '\t}',
    '',
    '\twhile (1)',
]
insert = '\n'.join(lines) + '\n'
if needle not in s:
    raise SystemExit('Starfighter.c insertion point not found')
p.write_text(s.replace(needle, insert, 1))

pre = Path('web/platform-pre.js')
js = pre.read_text()
js += "\n// Promo capture only: select a real game mission from the URL.\n"
js += "if (typeof location !== 'undefined') {\n"
js += "  const promoMission = new URLSearchParams(location.search).get('promo');\n"
js += "  if (promoMission) Module['arguments'] = ['--promo=' + promoMission];\n"
js += "}\n"
pre.write_text(js)
