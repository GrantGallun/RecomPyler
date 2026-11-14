# Fresh-return class c design

Retain handle functions. Create context-specific multi-value-return clones only at a caller use whose complete closed-use validation succeeds. Each call result gets its own virtual identity: a global allocation-site token cannot merge two calls or loop iterations. Keep payload/tag slots, every numeric operation, status check and error order. Return field slots on success, inert typed zero slots on checked failure; caller status checks remain before any use. Recursive fresh returns use the existing recursive SCC/clone ABI with a finite clone key. Unsupported nullable/polymorphic/mixed alias/fresh returns keep the handle form.

| Ray source site | Dynamic allocations | Return levels / consumers |
|---|---:|---|
| f2___sub__:t17 |277865| direct to render/intersectionTime/colourAt/baseColourAt/light visibility; also forwarded by normalAt into normalized (chain), no recursive fresh-return edge |
| f24_cross:t36 |2| single-level return to render, two distinct calls must get distinct virtual identities |
| f27___add__:t17 |20000| single-level return to render, two sequential calls |
| f16_scale:t7 |5333| one return into pointAtTime, consumed by Point addition; pointAtTime returns a different Point |
| f64_scale:t10 |5333| one return into reflectThrough, then scale/subtract chain |
| f68_scale:t13 |5333| one return into reflectThrough then subtraction |
| f70___sub__:t18 |5333| forwarded by reflectThrough to colourAt (two levels); calls live within rayColour recursion but the fresh-return chain itself is nonrecursive |

The seven sites sum319199. Existing cloned rayColour recursion can call these functions; that is distinct from an object being forwarded around a recursive fresh-return cycle, which receives a separate fail-first test.

The class-e site is f21_scale:t7 (Vector,133743). f12_normalized returns it, and Ray.__init__ stores that handle into Ray.direction; Ray.point is another retained child handle. Thus nesting applies to scalar Ray instances, but this first field-slot representation still stores child handles: eliminating a parent arena bump alone does not eliminate the Vector. At noncapturing normalized consumers a return clone can remove it independently; a nested virtual child requires an extended field representation and is not silently credited here. Other f21 callers are render's x/y scaled vectors and baseColourAt.

A fresh value whose caller may let it escape selects the original handle call before emission; that path has zero extra materialization/copy operations and the same checked allocation/growth/rollback order as today. The multi-value clone is used only when the caller's complete use grammar proves it stays virtual. This avoids making the escaping path slower, while class d separately builds conditional materialization. A clone initially tries mandatory return-producing calls, then greedily adds optional nonescaping fresh calls; unsupported use rejects just that candidate. Fail-first tests: repeated calls with equal fields, loop-carried previous-instance alias, recursive fresh factory, fresh result returned inside a container, a caller storing it, and numeric failure before the constructor/return.

The a+b candidate regresses30%; c is required and is the measured decision point. Final acceptance keeps only profitable lowering. Dynamic removal uses the same complete-pixel logical counter, then three alternating pairs; no source-site count is substituted for bumps or time.
