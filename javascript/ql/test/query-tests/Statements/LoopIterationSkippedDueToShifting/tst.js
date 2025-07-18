function removeX(string) {
  let parts = string.split('/');
  for (let i = 0; i < parts.length; ++i) {
    if (parts[i] === 'X') parts.splice(i, 1); // $ Alert
  }
  return parts.join('/');
}

function removeXInnerLoop(string, n) {
  let parts = string.split('/');
  for (let j = 0; j < n; ++j) {
    for (let i = 0; i < parts.length; ++i) {
      if (parts[i] === 'X') parts.splice(i, 1); // $ Alert
    }
  }
  return parts.join('/');
}

function removeXOuterLoop(string, n) {
  let parts = string.split('/');
  for (let i = 0; i < parts.length; ++i) {
    for (let j = 0; j < n; ++j) {
      if (parts[i] === 'X') {
        parts.splice(i, 1); // $ Alert
        break;
      }
    }
  }
  return parts.join('/');
}

function decrementAfter(string) {
  let parts = string.split('/');
  for (let i = 0; i < parts.length; ++i) {
    if (parts[i] === 'X') {
        parts.splice(i, 1);
        --i;
    }
  }
  return parts.join('/');
}

function postDecrementArgument(string) {
  let parts = string.split('/');
  for (let i = 0; i < parts.length; ++i) {
    if (parts[i] === 'X') {
        parts.splice(i--, 1);
    }
  }
  return parts.join('/');
}


function breakAfter(string) {
  let parts = string.split('/');
  for (let i = 0; i < parts.length; ++i) {
    if (parts[i] === 'X') {
        parts.splice(i, 1); // OK - only removes first occurrence
        break;
    }
  }
  return parts.join('/');
}

function insertNewElements(string) {
  let parts = string.split('/');
  for (let i = 0; i < parts.length; ++i) {
    if (parts[i] === 'X') {
        parts.splice(i, 1, '.'); // OK - no shifting due to insert
    }
  }
  return parts.join('/');
}

function spliceAfterLoop(string) {
  let parts = string.split('/');
  let i = 0;
  for (; i < parts.length; ++i) {
    if (parts[i] === 'X') break;
  }
  if (parts[i] === 'X') {
    parts.splice(i, 1); // OK - not inside loop
  }
  return parts.join('/');
}

function spliceAfterLoopNested(string) {
  let parts = string.split('/');
  for (let j = 0; j < parts.length; ++j) {
    let i = j;
    for (; i < parts.length; ++i) {
        if (parts[i] === 'X') break;
    }
    parts.splice(i, 1); // OK - not inside 'i' loop
  }
  return parts.join('/');
}

function removeAtSpecificPlace(string, k) {
  let parts = string.split('/');
  for (let i = 0; i < parts.length; ++i) {
    if (i === k && parts[i] === 'X') parts.splice(i, 1); // OK - more complex logic
  }
  return parts.join('/');
}

function removeFirstAndLast(string) {
  let parts = string.split('/');
  for (let i = 0; i < parts.length; ++i) {
    if (i === 0 || i === parts.length - 1) parts.splice(i, 1); // OK - out of scope of this query
  }
  return parts.join('/');
}

function inspectNextElement(string) {
  let parts = string.split('/');
  for (let i = 0; i < parts.length; ++i) {
    if (i < parts.length - 1 && parts[i] === parts[i + 1]) {
      parts.splice(i, 1); // OK - next element has been looked at
    }
  }
  return parts.join('/');
}

function withTryCatch(pendingCSS) {
  for (let i = 0; i < pendingCSS.length; ++i) {
      try {
          pendingCSS.splice(i, 1); // $ SPURIOUS:Alert
          i -= 1;
      } catch (ex) {}
  }
}

function andOperand(toc) {
  for (let i = 0; i < toc.length; i++) {
    toc[i].ignoreSubHeading && toc.splice(i, 1) && i--;
  }
}

function ifStatement(toc) {
  for (let i = 0; i < toc.length; i++) {
    if(toc[i].ignoreSubHeading){
      if(toc.splice(i, 1)){
        i--; 
      }
    }
  }
}

function ifStatement2(toc) {
  for (let i = 0; i < toc.length; i++) {
    if(toc[i].ignoreSubHeading){
      if(!toc.splice(i, 1)){ // $Alert
        i--;
      }
    }
  }
}
