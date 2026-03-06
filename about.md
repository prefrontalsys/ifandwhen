---
layout: note
title: "About"
kicker: "This site"
---

I build AI systems for a living. Not the kind that make headlines — the ones that have to work on Monday morning.

I'm a product manager and solution architect. I've spent years inside large financial institutions building systems that sit at the intersection of human judgment and machine capability. I'm also an independent researcher who studies how intelligence works across different substrates.

This site is where I think out loud about those questions. The essays here are not takes. They're attempts to work something out in public.

---

**If and When** takes its name from the word-order distinction at the center of the first essay. "When and if" treats arrival as the default. "If and when" leads with the uncertainty. That distinction is the operating principle for everything here.

You can reach me at <span class="eml" data-u="olleh" data-d="gro.nehwdnadfi">&#9993;</span>.

<script>
document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('.eml').forEach(function (el) {
    var u = el.dataset.u.split('').reverse().join('');
    var d = el.dataset.d.split('').reverse().join('');
    var addr = u + '@' + d;
    var a = document.createElement('a');
    a.href = 'mailto:' + addr;
    a.textContent = addr;
    el.replaceWith(a);
  });
});
</script>
