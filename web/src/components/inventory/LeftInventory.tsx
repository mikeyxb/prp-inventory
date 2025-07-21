import InventoryGrid from './InventoryGrid';
import { useAppSelector } from '../../store';
import { selectLeftInventory } from '../../store/inventory';

const LeftInventory: React.FC = () => {
  const leftInventory = useAppSelector(selectLeftInventory);

  const inventoryWithDefaultRarity = {
    ...leftInventory,
    items: leftInventory.items.map(item => ({
      ...item,
      rarity: item.rarity || 'common'
    })),
  };

  return <InventoryGrid inventory={inventoryWithDefaultRarity} inv={'left'} />;
};

export default LeftInventory;