(function(){
  var btn = document.getElementById('menuBtn');
  var panel = document.getElementById('mobilePanel');
  if(!btn || !panel) return;

  function close(){
    panel.classList.remove('open');
    btn.setAttribute('aria-expanded','false');
  }
  btn.addEventListener('click', function(){
    var open = btn.getAttribute('aria-expanded') === 'true';
    if(open){ close(); }
    else{ panel.classList.add('open'); btn.setAttribute('aria-expanded','true'); }
  });
  panel.querySelectorAll('a').forEach(function(a){ a.addEventListener('click', close); });
  window.addEventListener('resize', function(){ if(window.innerWidth > 980) close(); });
})();
