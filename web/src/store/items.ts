import { ItemData } from '../typings/item';

export const Items: {
  [key: string]: ItemData | undefined;
} = {
  water: {
    name: 'water',
    close: false,
    label: 'VODA',
    stack: true,
    usable: true,
    count: 0,
  },
  burger: {
    name: 'burger',
    close: true,
    label: 'BURGR',
    stack: true,
    usable: true,
    count: 0,
  },
  lockpick: {
    name: 'lockpick',
    close: true,
    label: 'Lockpick',
    stack: true,
    usable: true,
    count: 0
  },
  armour: {
    name: 'armour',
    close: false,
    label: 'Armour',
    stack: true,
    usable: true,
    count: 0,
  },
  garbage: {
    name: 'garbage',
    close: false,
    label: 'Garbage',
    stack: true,
    usable: true,
    count: 0,
  }
};
