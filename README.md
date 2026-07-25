# AirSpotX — plané, longe & lagune sur une seule carte

**Un planificateur de session vent.** Une carte satellite, **un vent partagé**, et trois
modes qui répondent tous à la même question — *« sur ce spot, avec ce vent, où puis-je
évoluer en sécurité ? »* :

| Calque | Question | Ce qu'on pose | Zone calculée |
|---|---|---|---|
| **GlideX** | J'atteins ma cible en plané ? | départ → arrivée + voile | empreinte atteignable (cercle décalé par le vent), verdict ✓/⚠/✕ |
| **AirsurfX** | Quelle zone au bout de ma corde ? | ancrage(s) + longueur | quart de cercle (±45°) sous le vent |
| **LagoonX** | Quand/où y a-t-il de l'eau ? | point sur le relief LiDAR | profondeur selon la marée, dans le temps |

Fusion **native** de trois prototypes : **GlideX** (plané), **AirsurfX** (longe),
**LagoonX** (lagune). Même socle : Leaflet, fonds satellite/OSM/topo **sans clé API**,
thème sombre « instrument ».

### Calques superposables

Les trois calques se **superposent** : les cases *Calques* montrent/cachent chacun
indépendamment, l'onglet choisit lequel s'édite (reçoit les clics + panneau). On peut ainsi
voir l'eau **LagoonX** sous la fenêtre de vol **AirsurfX**, ou l'empreinte **GlideX** par-dessus.

**Live : [airspotx.xavier-kain.fr](https://airspotx.xavier-kain.fr)** — ou ouvrir `index.html`.

## Ce qui est natif aujourd'hui

- **Coque partagée** : carte + fonds, recherche de spot (Nominatim), géolocalisation,
  **widget vent unique** (cadran draggable + ° et force en kt) piloté par tous les modes,
  sélecteur de mode, lien de partage, état mémorisé (localStorage), interface mobile.
- **Plané** : modèle « cercle décalé » porté de GlideX (§2 du brief), **validé** contre ses
  cas chiffrés (Bandit 16, 10 kt de cul, cible 500 m → arrivée 656 m sol, 28,8 s, 62,5 km/h).
  Base voiles (Flare Bandit / Moustache), fourchette de finesse best/prudente, marge de
  sécurité, temps de vol, vitesse sol, composante vent, verdict.
- **AirsurfX** : multi-cordes nommées, **fenêtre de vol en quart de cercle** (±45° sous le
  vent), étiquette de longueur sur la carte, poignée de position, curseur 100–1000 m (saisie
  libre jusqu'à 5 km).
  - **Plané depuis la corde (3D)** : corde fixe de longueur L attachée à l'ancrage. On règle la
    **hauteur h** sur la corde ; l'app place la position en l'air à la distance horizontale
    `√(L²−h²)` sous le vent, à l'altitude h, et calcule (finesse GlideX + vent) la **zone de
    plané atteignable** en larguant à cette hauteur + le **verdict de retour à l'ancrage**
    (plané amont contre le vent). C'est la combinaison GlideX × AirsurfX en 3D.
  - **Verrouillage longueur / vent** : fige l'un ou l'autre pour ne déplacer, à la souris,
    que la position du pilote dans la fenêtre (quart de cercle ±45°).
- **GlideX × AirsurfX** : option *« départ lié à la position sur la corde »* — le point de
  départ du plané se cale automatiquement sur la position 3D du pilote (hauteur + angle) de
  la corde sélectionnée, Δh = hauteur ; sinon départ libre.
- **LagoonX** : moteur repris **verbatim** (seuil hydraulique par *priority-flood*, marée
  Open-Meteo). Clic → analyse d'une zone ~3×3 km, overlay de profondeur coloré, **barre
  temporelle** (Maintenant / ±15 min / ▶) qui remplit et vide l'eau, prochaines PM/BM +
  coefficient, sonde de point, calibration (décalage niveau/horaire, retard, rétention).
  Relief à **3 sources** avec repli automatique : IGN España MDT05 (5 m) / IGN France RGE ALTI
  (5 m), puis, en secours ou hors couverture, **terrain mondial AWS Terrarium** (~10 m, sans
  clé, CORS) — donc LagoonX marche partout et résiste aux pannes intermittentes IGN (retry ×3).

## Partage

Le bouton 🔗 copie un lien contenant **tout l'état** (mode, vent, cordes, plané, vue) —
encodé dans `#s=…`. L'URL de la barre d'adresse reste synchronisée en continu.

## Limites (héritées de GlideX)

- Plané : sol plat supposé à l'arrivée, **relief intermédiaire non modélisé** (prochaine
  feature sécu), vent uniforme, vitesse best glide constante. Modèle non borné si vent ≥
  vitesse air (avertissement affiché).
- **Finesses = estimations** tant que non calibrées sur tracklogs (voir GlideX).
- Ne remplace pas le jugement du pilote.

## Déploiement

```bash
bash deploy.sh   # rsync → airspotx.xavier-kain.fr
```

## Roadmap

1. **Profil de relief** sous la trajectoire de plané (alerte franchissement d'obstacle).
2. Vent réel du spot (Open-Meteo) pré-rempli sur le cadran, partagé par les calques.
3. LagoonX : courbe de marée interactive + fenêtres de mise en eau (héritées du proto complet).
4. Voiles calibrées par tracklogs, altitude sol auto (Open-Meteo elevation).
5. PWA offline terrain (cache tuiles + données).
