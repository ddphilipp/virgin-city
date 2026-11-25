const CACHE='virgin-city-shell-v3';
const SHELL=['/','/index.html'];
const SDK='https://esm.sh/@neondatabase/neon-js@latest?bundle';
self.addEventListener('install',event=>event.waitUntil((async()=>{const c=await caches.open(CACHE);await c.addAll(SHELL);try{await c.add(new Request(SDK,{mode:'cors'}))}catch(e){}await self.skipWaiting()})()));
self.addEventListener('activate',event=>event.waitUntil(caches.keys().then(keys=>Promise.all(keys.filter(k=>k!==CACHE).map(k=>caches.delete(k)))).then(()=>self.clients.claim())));
self.addEventListener('fetch',event=>{
 const u=new URL(event.request.url);
 if(event.request.method!=='GET'||(u.origin!==self.location.origin&&u.hostname!=='esm.sh'))return;
 event.respondWith(caches.match(event.request).then(cached=>cached||fetch(event.request).then(response=>{if(response.ok){const copy=response.clone();caches.open(CACHE).then(c=>c.put(event.request,copy))}return response}).catch(()=>cached||caches.match('/index.html'))));
});
