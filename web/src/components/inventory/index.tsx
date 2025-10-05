import React, { useEffect, useState } from 'react';
import useNuiEvent from '../../hooks/useNuiEvent';
import InventoryHotbar from './InventoryHotbar';
import { useAppDispatch } from '../../store';
import { refreshSlots, setAdditionalMetadata, setupInventory } from '../../store/inventory';
import { useExitListener } from '../../hooks/useExitListener';
import type { Inventory as InventoryProps } from '../../typings';
import RightInventory from './RightInventory';
import LeftInventory from './LeftInventory';
import Tooltip from '../utils/Tooltip';
import { closeTooltip } from '../../store/tooltip';
import InventoryContext from './InventoryContext';
import { closeContextMenu } from '../../store/contextMenu';
import Fade from '../utils/transitions/Fade';
import { Locale } from '../../store/locale';
import Utilities from './Utilities';

const Inventory: React.FC = () => {
  const [inventoryVisible, setInventoryVisible] = useState(false);
  const dispatch = useAppDispatch();

  useNuiEvent<boolean>('setInventoryVisible', setInventoryVisible);
  useNuiEvent<false>('closeInventory', () => {
    setInventoryVisible(false);
    dispatch(closeContextMenu());
    dispatch(closeTooltip());
  });
  useExitListener(setInventoryVisible);

  useNuiEvent<{
    leftInventory?: InventoryProps;
    rightInventory?: InventoryProps;
  }>('setupInventory', (data) => {
    dispatch(setupInventory(data));
    !inventoryVisible && setInventoryVisible(true);
  });

  useNuiEvent('refreshSlots', (data) => dispatch(refreshSlots(data)));

  useNuiEvent('displayMetadata', (data: Array<{ metadata: string; value: string }>) => {
    dispatch(setAdditionalMetadata(data));
  });

  // UTILITY
  const [activeTab, setActiveTab] = useState<'utilities' | 'inventories'>('inventories');

  // Hides the context menu on ESC
  useEffect(() => {
    if (!inventoryVisible) return;

    const keyHandler = (event: KeyboardEvent) => {
      const target = event.target as HTMLElement;

      // Ignore if typing in an input, textarea, or contenteditable element
      if (
        target.tagName === 'INPUT' ||
        target.tagName === 'TEXTAREA' ||
        target.isContentEditable
      ) {
        return
      }

      const key = event.key.toLowerCase();

      switch (key) {
        case 'q':
          return setActiveTab('inventories');
        case 'e':
          return setActiveTab('utilities');
      }
    };

    window.addEventListener('keydown', keyHandler);

    return () => window.removeEventListener('keydown', keyHandler);
  }, [inventoryVisible]);

  return (
    <>
      <Fade in={inventoryVisible}>
        {/* <div className='font-[Oswald] text-[15px] text-white flex items-center gap-3 absolute top-5 right-5 z-10'>
          <div className={`flex items-center gap-3 bg-black/65 px-5 py-2 rounded border transition-all duration-200 w-fit
            ${activeTab === 'inventories' ? 'border-cyan-500 bg-cyan-900/75' : 'border-neutral-600'}`}>
              <p className="bg-black/50 px-1.5 rounded-sm text-[13px]">Q</p>
              <p>{(Locale.inventories || 'Inventories').toUpperCase()}</p>
          </div>
          <div className={`flex items-center gap-3 bg-black/65 px-5 py-2 rounded border transition-all duration-200 w-fit
            ${activeTab === 'utilities' ? 'border-cyan-500 bg-cyan-900/75' : 'border-neutral-600'}`}>
              <p>{(Locale.utilities || 'Utility').toUpperCase()}</p>
              <p className="bg-black/50 px-1.5 rounded-sm text-[13px]">E</p>
          </div>
        </div> */}
        <div>
          <LeftInventory />

          {/* <Fade in={activeTab === 'inventories'}> */}
            <RightInventory />
          {/* </Fade> */}

          {/* <Fade in={activeTab === 'utilities'}> */}
            <Utilities />
          {/* </Fade> */}

          <Tooltip />
          <InventoryContext />
        </div>
      </Fade>
      <InventoryHotbar />
    </>
  );
};

export default Inventory;
