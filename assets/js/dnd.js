/**
 * For drag and dropping of cards and piles
 */

const bodyClassWhenDragging = 'dnd-dragging';

// Utility (non-exported) function for finding a data attribute in a parent element
const findDataFromParent = function findDataFromParent(el, dataKey) {
  if (el.dataset[dataKey]) {
    return el.dataset[dataKey];
  } else if (el.parentElement) {
    return findDataFromParent(el.parentElement, dataKey);
  }
};

const handleDrop = function drop(pathPart, data) {
  ev.preventDefault();
  document.body.classList.remove(bodyClassWhenDragging);
  const boardId = document.querySelector('meta[name=board_id]').getAttribute('content');

  const request = new XMLHttpRequest();
  request.open('POST', `/boards/${boardId}/${pathPart}`, true);
  request.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');
  request.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name=csrf]').content);
  request.send(JSON.stringify(data));
};

const drag = function drag(ev) {
  ev.dataTransfer.setData('cardId', findDataFromParent(ev.target, 'cardId'));
  ev.dataTransfer.setData('pileId', findDataFromParent(ev.target, 'pileId'));
  ev.dataTransfer.dropEffect = 'copy';
  document.body.classList.add(bodyClassWhenDragging);
};

const allowDrop = function allowDrop(ev) {
  ev.target.classList.add('active');
  ev.preventDefault();
};

const dragLeave = function dragLeave(ev) {
  ev.target.classList.remove('active');
};

const dropIntoPile = function dropIntoPile(ev) {
  cardId = ev.dataTransfer.getData('cardId');
  pileId = ev.dataTransfer.getData('pileId');

  handleDrop('dnd-into-pile', {
    what: cardId ? 'card' : 'pile',
    what_id: cardId || pileId,
    pile_id: findDataFromParent(ev.target, 'pileId'),
  });
};

const dropIntoJunction = function dropIntoJunction(ev) {
  handleDrop('dnd-into-junction', {
    new_pos: findDataFromParent(ev.target, 'pos'),
    col_id: findDataFromParent(ev.target, 'colId'),
  });
};

module.exports = { drag, dragLeave, allowDrop, dropIntoPile, dropIntoJunction };