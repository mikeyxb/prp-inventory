import { ItemData } from '../typings/item';

export const Items: {
  [key: string]: ItemData;
} = {
  water: {
    name: 'water',
    close: false,
    rarity: 'common',
    label: 'VODA',
    stack: true,
    usable: true,
    count: 0,
  },
  burger: {
    name: 'burger',
    close: true,
    rarity: 'uncommon',
    label: 'BURGR',
    stack: true,
    usable: true,
    count: 0,
  },
  lockpick: {
    name: 'lockpick',
    close: true,
    label: 'Lockpick',
    rarity: 'rare',
    stack: true,
    usable: true,
    count: 0,
  },
  armour: {
    name: 'armour',
    close: false,
    label: 'Armour',
    rarity: 'epic',
    stack: true,
    usable: true,
    count: 0,
  },
  garbage: {
    name: 'garbage',
    close: false,
    label: 'Garbage',
    rarity: 'legendary',
    stack: true,
    usable: true,
    count: 0,
  },
};
