import InventoryComponent from './components/inventory';
import useNuiEvent from './hooks/useNuiEvent';
import { Items } from './store/items';
import { Locale } from './store/locale';
import { setImagePath } from './store/imagepath';
import { setupInventory } from './store/inventory';
import { Inventory, SlotWithItem } from './typings';
import { PlayerID, useAppDispatch } from './store';
import { debugData } from './utils/debugData';
import DragPreview from './components/utils/DragPreview';
import { fetchNui } from './utils/fetchNui';
import { useDragDropManager } from 'react-dnd';
import KeyPress from './components/utils/KeyPress';

declare global {
  interface Window {
    debugInventory?: {
      showBackpack: () => void;
      showShop: () => void;
      showBackpackWithShop: () => void;
    };
  }
}

const debugPlayerInventory: Inventory = {
  id: 'debug-player',
  type: 'player',
  slots: 32,
  label: 'Bob Smith',
  maxWeight: 5000,
  items: [
    {
      slot: 1,
      name: 'water',
      weight: 100,
      count: 4,
      metadata: { description: 'Refreshing water' },
    },
    {
      slot: 3,
      name: 'armour',
      weight: 2000,
      count: 2,
      metadata: { description: 'Bulletproof vest with some scuffs', durability: 74 },
    },
    { slot: 4, name: 'garbage', weight: 600, count: 5, metadata: { description: 'Stinks!!' } },
    {
      slot: 5,
      name: 'burger',
      weight: 1000,
      count: 5,
      metadata: { description: 'Delicious burger', durability: 27 },
    },
    {
      slot: 6,
      name: 'small_backpack',
      weight: 1200,
      count: 1,
      metadata: {
        label: 'Trail Pack',
        description: 'Lightweight hiking pack',
        container: 'debug-bag-1',
        size: [30, 20000],
        weight: 4200,
        durability: 100,
      },
    },
    {
      slot: 12,
      name: 'armour_plate',
      weight: 250,
      count: 1,
      metadata: { description: 'Emergency plate for hasty repairs' },
    },
  ],
};

const debugBackpackInventory: Inventory = {
  id: 'debug-bag-1',
  type: 'container',
  slots: 30,
  label: 'Trail Pack',
  maxWeight: 20000,
  items: [
    {
      slot: 1,
      name: 'bandage',
      weight: 115,
      count: 3,
      metadata: { description: 'Always handy in a pinch.' },
    },
    {
      slot: 2,
      name: 'water',
      weight: 100,
      count: 2,
      metadata: { description: 'Stay hydrated on the trail.' },
    },
    {
      slot: 3,
      name: 'burger',
      weight: 250,
      count: 2,
      metadata: { description: 'Trail snacks for later.' },
    },
    {
      slot: 7,
      name: 'lockpick',
      weight: 500,
      count: 1,
      metadata: { description: 'Compact toolkit stored in the bag.' },
    },
    { slot: 12, weight: 0 },
    { slot: 18, weight: 0 },
    { slot: 24, weight: 0 },
  ],
};

const debugShopItems: SlotWithItem[] = [
  {
    slot: 1,
    name: 'lockpick',
    count: 1,
    price: 2500,
    weight: 500,
    metadata: {
      description: 'Simple lockpick that breaks easily and can pick basic door locks.',
      label: 'Lockpick',
    },
  },
  {
    slot: 2,
    name: 'boombox',
    count: 1,
    price: 12500,
    weight: 2500,
    metadata: {
      description: 'Portable speaker for pop-up block parties.',
      label: 'Street Boombox',
    },
  },
  {
    slot: 5,
    name: 'armour',
    count: 1,
    price: 8500,
    weight: 2000,
    metadata: {
      description: 'Heavy armour vest direct from the supplier.',
      label: 'Heavy Armour Vest',
    },
  },
  {
    slot: 6,
    name: 'water',
    count: 10,
    price: 18,
    weight: 100,
    metadata: {
      description: 'Bulk bottled water for job sites.',
      label: 'Aquabreak 12-pack',
    },
  },
  {
    slot: 7,
    name: 'burger',
    count: 6,
    price: 25,
    weight: 1000,
    metadata: {
      description: 'Neighbourhood grill combo meal voucher.',
      label: 'Daily Special Burger',
    },
  },
  {
    slot: 12,
    name: 'kerosene',
    count: 2,
    price: 640,
    weight: 700,
    metadata: {
      description: 'Industrial-grade kerosene fuel canister.',
      label: 'Blue Flame Fuel',
    },
  },
  {
    slot: 14,
    name: 'filter',
    count: 4,
    price: 120,
    weight: 150,
    metadata: {
      description: 'High-efficiency particulate filter.',
      label: 'HEPA Filter Cartridge',
    },
  },
];

const debugShopInventory: Inventory = {
  id: 'debug-youtool',
  type: 'shop',
  label: 'YouTool Hardware',
  slots: 25,
  items: debugShopItems,
  accounts: ['money', 'bank', 'black_money'],
};

const backpackDebugEvent = {
  action: 'setupInventory',
  data: {
    leftInventory: debugPlayerInventory,
    rightInventory: debugBackpackInventory,
  },
};

const shopDebugEvent = {
  action: 'setupInventory',
  data: {
    leftInventory: debugPlayerInventory,
    rightInventory: debugShopInventory,
  },
};

debugData([
  { ...backpackDebugEvent, delay: 200 },
  { ...shopDebugEvent, delay: 900 },
]);

if (import.meta.env.DEV && typeof window !== 'undefined') {
  window.debugInventory = {
    showBackpack: () => debugData([{ ...backpackDebugEvent, delay: 0 }], 0),
    showShop: () => debugData([{ ...shopDebugEvent, delay: 0 }], 0),
    showBackpackWithShop: () =>
      debugData(
        [
          { ...backpackDebugEvent, delay: 0 },
          { ...shopDebugEvent, delay: 500 },
        ],
        0
      ),
  };
}

const App: React.FC = () => {
  const dispatch = useAppDispatch();
  const manager = useDragDropManager();

  useNuiEvent<{
    serverId: number;
    locale: { [key: string]: string };
    items: typeof Items;
    leftInventory: Inventory;
    imagepath: string;
  }>('init', ({ serverId, locale, items, leftInventory, imagepath }) => {
    for (const name in locale) Locale[name] = locale[name];
    for (const name in items) Items[name] = items[name];
    PlayerID[0] = serverId;

    setImagePath(imagepath);
    dispatch(setupInventory({ leftInventory }));
  });

  fetchNui('uiLoaded', {});

  useNuiEvent('closeInventory', () => {
    manager.dispatch({ type: 'dnd-core/END_DRAG' });
  });

  return (
    <>
      <InventoryComponent />
      <DragPreview />
      <KeyPress />
    </>
  );
};

addEventListener('dragstart', function (event) {
  event.preventDefault();
});

export default App;
