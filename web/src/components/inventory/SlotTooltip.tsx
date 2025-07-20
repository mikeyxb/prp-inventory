import { Inventory, SlotWithItem } from '../../typings';
import React, { Fragment, useMemo } from 'react';
import { Items } from '../../store/items';
import { Locale } from '../../store/locale';
import ReactMarkdown from 'react-markdown';
import { useAppSelector } from '../../store';
import ClockIcon from '../utils/icons/ClockIcon';
import { getItemUrl } from '../../helpers';
import Divider from '../utils/Divider';

const SlotTooltip: React.ForwardRefRenderFunction<
  HTMLDivElement,
  { item: SlotWithItem; inventoryType: Inventory['type']; style: React.CSSProperties }
> = ({ item, inventoryType, style }, ref) => {
  const additionalMetadata = useAppSelector((state) => state.inventory.additionalMetadata);
  const itemData = useMemo(() => Items[item.name], [item]);
  const ingredients = useMemo(() => {
    if (!item.ingredients) return null;
    return Object.entries(item.ingredients).sort((a, b) => a[1] - b[1]);
  }, [item]);
  const description = item.metadata?.description || itemData?.description;
  const ammoName = itemData?.ammoName && Items[itemData?.ammoName]?.label;

  return (
    <>
      {!itemData ? (
        <div ref={ref} style={style}>
          <div className="metadata">
                <p className="value">{item.name}</p>
            </div>
        </div>
      ) : (
        <div style={{ ...style }} ref={ref} className='flex flex-col gap-1'>
          <div>
            <div className="metadata">
              <p className='value'>{item.metadata?.label || itemData.label || item.name}</p>
            </div>
            {inventoryType === 'crafting' ? (
              <div className="tooltip-crafting-duration">
                <ClockIcon />
                <p>{(item.duration !== undefined ? item.duration : 3000) / 1000}s</p>
              </div>
            ) : (
              <p>{item.metadata?.type}</p>
            )}
          </div>
          {description && (
            <div className="metadata">
              <p className='label'>{(Locale.description || 'Description').toUpperCase()}:</p>
              <p className='value'>{description}</p>
            </div>
          )}
          {inventoryType !== 'crafting' ? (
            <>
              {item.durability !== undefined && (
                <p>
                  {Locale.ui_durability}: {Math.trunc(item.durability)}
                </p>
              )}
              {item.metadata?.ammo !== undefined && (
                <div className="metadata">
                  <p className='label'>{(Locale.ui_ammo || 'Ammo').toUpperCase()}:</p>
                  <p className='value'>{item.metadata.ammo}</p>
                </div>
              )}
              {typeof item.metadata === 'object' &&
              Object.entries(item.metadata).map(([key, val]) => {
                if (typeof val === 'object' && val?.show && typeof val.show === 'object') {
                  return (
                    <div className="metadata" key={key}>
                      <p className="label">{val.show.label?.toUpperCase() || key.toUpperCase()}:</p>
                      <p className="value">{val.show.value}</p>
                    </div>
                  );
                }
                return null;
              })}
              {item.metadata?.serial && (
                <div className="metadata">
                  <p className='label'>{(Locale.ui_serial || 'Serial number').toUpperCase()}:</p>
                  <p className='value'>{item.metadata.serial}</p>
                </div>
              )}
              {additionalMetadata.map((data: { metadata: string; value: string }, index: number) => (
                <Fragment key={`metadata-${index}`}>
                  {item.metadata && item.metadata[data.metadata] && (
                    <p>
                      {data.value}: {item.metadata[data.metadata]}
                    </p>
                  )}
                </Fragment>
              ))}
            </>
          ) : (
            <div className="tooltip-ingredients">
              {ingredients &&
                ingredients.map((ingredient) => {
                  const [item, count] = [ingredient[0], ingredient[1]];
                  return (
                    <div className="tooltip-ingredient" key={`ingredient-${item}`}>
                      <img src={item ? getItemUrl(item) : 'none'} alt="item-image" />
                      <p>
                        {count >= 1
                          ? `${count}x ${Items[item]?.label || item}`
                          : count === 0
                          ? `${Items[item]?.label || item}`
                          : count < 1 && `${count * 100}% ${Items[item]?.label || item}`}
                      </p>
                    </div>
                  );
                })}
            </div>
          )}
        </div>
      )}
    </>
  );
};

export default React.forwardRef(SlotTooltip);
