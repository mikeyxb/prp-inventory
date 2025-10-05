import InventoryGrid from './InventoryGrid';
import { useAppSelector } from '../../store';
import { selectContainerSlot, selectRightInventory } from '../../store/inventory';
import { InventoryType } from '../../typings';

const RightInventory: React.FC = () => {
  const rightInventory = useAppSelector(selectRightInventory);
  const containerSlot = useAppSelector(selectContainerSlot);

  if (
    rightInventory.type === InventoryType.CONTAINER &&
    containerSlot?.metadata?.container === rightInventory.id
  ) {
    return null;
  }

  return <InventoryGrid inventory={rightInventory} inv={'right'} />;
};

export default RightInventory;
