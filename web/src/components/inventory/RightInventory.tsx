import InventoryGrid from './InventoryGrid';
import { useAppSelector } from '../../store';
import { selectRightInventory } from '../../store/inventory';

const RightInventory: React.FC = () => {
  const rightInventory = useAppSelector(selectRightInventory);

  const inventoryWithDefaultRarity = {
    ...rightInventory,
    items: rightInventory.items.map(item => ({
      ...item,
      rarity: item.rarity || 'common'
    })),
  };

  return <InventoryGrid inventory={inventoryWithDefaultRarity} inv={'right'} />;
};

export default RightInventory;
