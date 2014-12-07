part of ld31;

Map<String, ImageElement> images;
Map<String, AudioElement> sounds;

void loadResources() {
  images = new Map<String, ImageElement>();
  images['instructions'] = new ImageElement(src: 'res/instructions.png');
  images['background'] = new ImageElement(src: 'res/background.png');
  images['player'] = new ImageElement(src: 'res/player.png');
  images['pacm'] = new ImageElement(src: 'res/pacm.png');
  images['strawb'] = new ImageElement(src: 'res/strawb.png');
  images['strawb-bullet'] = new ImageElement(src: 'res/strawb-bullet.png');
  images['cherr'] = new ImageElement(src: 'res/cherr.png');
  images['ghos'] = new ImageElement(src: 'res/ghos.png');
  images['bullet'] = new ImageElement(src: 'res/bullet.png');
  images['spawner'] = new ImageElement(src: 'res/spawner.png');
  images['health-station'] = new ImageElement(src: 'res/health-station.png');
  images['upgrade-station'] = new ImageElement(src: 'res/upgrade-station.png');
  images['heart'] = new ImageElement(src: 'res/heart.png');
  images['health-text'] = new ImageElement(src: 'res/health-text.png');
  images['bullets-text'] = new ImageElement(src: 'res/bullets-text.png');
  images['kill-text'] = new ImageElement(src: 'res/kill-text.png');
  images['upgrade-text'] = new ImageElement(src: 'res/upgrade-text.png');
  images['boss-text'] = new ImageElement(src: 'res/boss-text.png');
  images['dialog-1'] = new ImageElement(src: 'res/dialog-1.png');
  images['dialog-2'] = new ImageElement(src: 'res/dialog-2.png');
  images['win'] = new ImageElement(src: 'res/win.png');
  images['death'] = new ImageElement(src: 'res/death.png');
  sounds = new Map<String, AudioElement>();
  sounds['damage'] = new AudioElement('res/damage.wav');
  sounds['hurt'] = new AudioElement('res/hurt.wav');
  sounds['kill'] = new AudioElement('res/kill.wav');
  sounds['shoot'] = new AudioElement('res/shoot.wav');
  sounds['spawn'] = new AudioElement('res/spawn.wav');
  sounds['win'] = new AudioElement('res/win.wav');
  sounds['death'] = new AudioElement('res/death.wav');
}