import InventoryComponent from './components/inventory';
import useNuiEvent from './hooks/useNuiEvent';
import { Items } from './store/items';
import { Locale } from './store/locale';
import { setImagePath } from './store/imagepath';
import { setupInventory } from './store/inventory';
import { Inventory } from './typings';
import { useAppDispatch } from './store';
import { debugData } from './utils/debugData';
import DragPreview from './components/utils/DragPreview';
import { fetchNui } from './utils/fetchNui';
import { useDragDropManager } from 'react-dnd';
import KeyPress from './components/utils/KeyPress';

debugData([
  {
    action: 'setupInventory',
    data: {
      leftInventory: {
        id: 'test',
        type: 'player',
        slots: 32,
        label: 'Bob Smith',
        weight: 3000,
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
            metadata: { description: 'Bulletprof', durability: 74 },
          },
          { slot: 4, name: 'garbage', weight: 600, count: 5, metadata: { description: 'Stinks!!' } },
          {
            slot: 5,
            name: 'burger',
            weight: 1000,
            count: 5,
            metadata: { description: 'Delicious burger', durability: 27 },
          },
        ],
      },
      /*
      rightInventory: {
        id: 'shop',
        type: 'crafting',
        slots: 3,
        label: 'YouTool',
        weight: 3000,
        maxWeight: 5000,
        items: [
          {
            slot: 1,
            name: 'lockpick',
            weight: 500,
            ingredients: {
              burger: 1,
              water: 2,
            },
            count: 1,
            duration: 5000,
            metadata: {
              description: 'Simple lockpick that breaks easily and can pick basic door locks',
            },
          },
          {
            slot: 2,
            name: 'burger',
            weight: 250,
            count: 1,
            metadata: {
              description: 'Simple lockpick that breaks easily and can pick basic door locks',
            },
          },
          {
            slot: 3,
            name: 'armour',
            weight: 1000,
            ingredients: {
              garbage: 7,
            },
            count: 2,
            duration: 10000,
          },
        ],
      },*/
      rightInventory: {
        id: 'shop',
        type: 'shop',
        slots: 5,
        label: 'YouTool',
        weight: 3000,
        maxWeight: 5000,
        items: [
          {
            slot: 1,
            name: 'lockpick',
            weight: 500,
            price: 300,
            count: 1,
            metadata: {
              description: 'Simple lockpick that breaks easily and can pick basic door locks',
            },
          },
          {
            slot: 2,
            name: 'armour',
            metadata: { durability: 100 },
            weight: 1000,
            price: 750,
            count: 1,
          },
          {
            slot: 3,
            name: 'water',
            metadata: { description: 'Refreshing water.' },
            price: 5,
            weight: 100,
            count: 1
          },
          {
            slot: 4,
            name: 'burger',
            price: 10,
            weight: 250,
            count: 1
          },
          {
            slot: 5,
            name: 'garbage',
            price: 1000,
            metadata: { description: 'Surprise.' },
            weight: 1500,
            count: 1
          }
        ],
      }
    },
  },
]);

const App: React.FC = () => {
  const dispatch = useAppDispatch();
  const manager = useDragDropManager();

  useNuiEvent<{
    locale: { [key: string]: string };
    items: typeof Items;
    leftInventory: Inventory;
    imagepath: string;
  }>('init', ({ locale, items, leftInventory, imagepath }) => {
    for (const name in locale) Locale[name] = locale[name];
    for (const name in items) Items[name] = items[name];

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
