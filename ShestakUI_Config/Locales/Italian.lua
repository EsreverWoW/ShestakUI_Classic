local _, L = ...
if GetLocale() ~= "itIT" then return end

----------------------------------------------------------------------------------------
--	Localization for itIT client
--	Translation: Oz
----------------------------------------------------------------------------------------
L_GUI_SET_SAVED_SETTTINGS = "Imposta le impostazioni 'Per-Personaggio'"
L_GUI_SET_SAVED_SETTTINGS_DESC = "Switch between a profile that applies to all characters and one that is unique to this character." -- Need review
L_GUI_RESET_CHAR = "Vuoi davvero ripristinare le impostazioni iniziali della ShestakUI per questo personaggio?"
L_GUI_RESET_ALL = "Vuoi davvero ripristinate tutte le impostazioni iniziali della ShestakUI?"
L_GUI_PIXEL_FONT_CHAR = "Are you sure you want to reset your character's font settings to the pixel font style?" -- Need review
L_GUI_PIXEL_FONT_ALL = "Are you sure you want to reset all of your font settings to the pixel font style?" -- Need review
L_GUI_NORMAL_FONT_CHAR = "Are you sure you want to reset your character's font settings to the normal font style?" -- Need review
L_GUI_NORMAL_FONT_ALL = "Are you sure you want to reset all of your font settings to the normal font style?" -- Need review
L_GUI_PER_CHAR = "Vuoi davvero modificare questa impostazione (attivazione/disattivazione salvataggio impostazioni 'Per-Personaggio')?"
L_GUI_NEED_RELOAD = "|cffff2735You need to reload the UI to apply your changes.|r" -- Need review

-- General options
L_GUI_GENERAL_SUBTEXT = "These settings control the general user interface settings. Type in chat '/uihelp' for help." -- Need review
L_GUI_GENERAL_WELCOME_MESSAGE = "Messaggio di benvenuto in chat"
L_GUI_GENERAL_AUTOSCALE = "Ridimensionamento automatico dell'interfaccia"
L_GUI_GENERAL_UISCALE = "Scala dell'interfaccia (se il ridimensionamento automatico è disabilitato)"
L_GUI_GENERAL_BOTTOMLINES = "Show Bottom Panel Lines" -- Need review
L.general_subheader_font_style = "Global font style (presets which overwrite individual font settings)" -- Need review
L.media_border_color = "Color for borders" -- Need review
L.media_backdrop_color = "Color for borders backdrop" -- Need review
L.media_backdrop_alpha = "Alpha for transparent backdrop" -- Need review
L.media_subheader_pixel = "Change Pixel font" -- Need review

-- Font options
L.font = "Fonts" -- Need review
L.font_subtext = "Customize individual fonts for elements." -- Need review
L.font_stats_font = "Select font" -- Need review
L.font_stats_font_style = "Font flag" -- Need review
L.font_stats_font_shadow = "Font shadow" -- Need review
L.font_subheader_stats = "Stats font" -- Need review
L.font_subheader_combat = "Combat text font" -- Need review
L.font_subheader_chat = "Chat font" -- Need review
L.font_subheader_chat_tabs = "Chat tabs font" -- Need review
L.font_subheader_action = "Action bars font" -- Need review
L.font_subheader_threat = "Threat meter font" -- Need review
L.font_subheader_raidcd = "Raid cooldowns font" -- Need review
L.font_subheader_cooldown = "Cooldowns timer font" -- Need review
L.font_subheader_loot = "Loot font" -- Need review
L.font_subheader_nameplates = "Nameplates font" -- Need review
L.font_subheader_unit = "Unit frames font" -- Need review
L.font_subheader_aura = "Auras font" -- Need review
L.font_subheader_filger = "Filger font" -- Need review
L.font_subheader_style = "Stylization font" -- Need review
L.font_subheader_bag = "Bags font" -- Need review

-- Skins options
L_GUI_SKINS = "Restyling"
L_GUI_SKINS_SUBTEXT = "Change the appearance of the standard interface." -- Need review
L_GUI_SKINS_BLIZZARD = "Attiva il restyling dei riquadri Blizzard"
L_GUI_SKINS_MINIMAP_BUTTONS = "Attiva il restyling dei pulsanti delle AddOns sulla minimappa"
L_GUI_SKINS_SUBHEADER = "Stylization of addons" -- Need review
L_GUI_SKINS_DBM_MOVABLE = "Consenti di poter spostare le barre di DBM"

-- Unit Frames options
L_GUI_UF_SUBTEXT = "Customize player, target frames and etc." -- Need review
L_GUI_UF_ENABLE = "Abilita i riquadri delle unità"
L_GUI_UF_OWN_COLOR = "Scegli il colore per la tua barra della salute"
L_GUI_UF_UF_COLOR = "Colore barre salute (se è attivo il colore per la tua barra della salute)"
L_GUI_UF_ENEMY_HEALTH_COLOR = "Colora di rosso la barra della salute dei nemici"
L_GUI_UF_TOTAL_VALUE = "Visualizza un testo sui riquadri di giocatore e bersaglio con i valori XXXX/Totale"
L_GUI_UF_COLOR_VALUE = "Valori di salute e mana colorati"
L_GUI_UF_BAR_COLOR_VALUE = "Barra della salute colorata in base alla salute restante"
L_GUI_UF_LINES = "Mostra le linee per giocatore e bersaglio"
L_GUI_UF_PLAYER_NAME = "Show player's name and level" -- Needs review
L_GUI_UF_BAR_COLOR_HAPPINESS = "Color pet health bar by happiness" -- Needs review
L_GUI_UF_SUBHEADER_CAST = "Castbars" -- Need review
L_GUI_UF_UNIT_CASTBAR = "Mostra le barre incantesimi"
L_GUI_UF_CASTBAR_ICON = "Mostra le icone della barra incantesimi"
L_GUI_UF_CASTBAR_LATENCY = "Latenza della barra incantesimi"
L_GUI_UF_CASTBAR_TICKS = "Mostra le tacchette (ticks) sulla barra incantesimi"
L_GUI_UF_SUBHEADER_FRAMES = "Frames" -- Need review
L_GUI_UF_SHOW_PET = "Mostra il riquadro per il famiglio"
L_GUI_UF_SHOW_FOCUS = "Mostra il riquadro per il focus"
L_GUI_UF_SHOW_TOT = "Mostra il riquadro per il bersaglio del bersaglio"
L_GUI_UF_SHOW_BOSS = "Mostra i riquadri per i bosses"
L_GUI_UF_BOSS_RIGHT = "Riquadri per i bosses sulla destra"
L_GUI_UF_SHOW_ARENA = "Mostra i riquadri per l'arena"
L_GUI_UF_ARENA_RIGHT = "Riquadri per l'arena sulla destra"
L_GUI_UF_BOSS_DEBUFFS = "Number of debuffs" -- Need review
L_GUI_UF_BOSS_DEBUFFS_DESC = "Numero di penalità sui riquadri dei bosses"
L_GUI_UF_BOSS_BUFFS = "Number of buffs" -- Need review
L_GUI_UF_BOSS_BUFFS_DESC = "Numero di benefici sui riquadri dei bosses"
L_GUI_UF_ICONS_PVP = "Testo PvP (senza icona) al passaggio del mouse sui riquadri di giocatore e bersaglio"
L_GUI_UF_ICONS_COMBAT = "Icona di status 'in combattimento'"
L_GUI_UF_ICONS_RESTING = "Icona 'Riposato' per personaggi di basso livello"
L_GUI_UF_SUBHEADER_PORTRAIT = "Portraits" -- Need review
L_GUI_UF_PORTRAIT_ENABLE = "Attiva ritratti per giocatore e bersaglio"
L_GUI_UF_PORTRAIT_CLASSCOLOR_BORDER = "Bordi dei ritratti colorati in base alla classe"
L_GUI_UF_PORTRAIT_HEIGHT = "Altezza del ritratto"
L_GUI_UF_PORTRAIT_WIDTH = "Larghezza del ritratto"
L_GUI_UF_SUBHEADER_PLUGINS = "Plugins" -- Need review
L_GUI_UF_PLUGINS_GCD = "Scintilla del recupero globale"
L_GUI_UF_PLUGINS_ENERGY_TICKER = "Enable energy ticker" -- Needs review
L_GUI_UF_PLUGINS_SWING = "Attiva la barra dei fendenti"
L.unitframe_plugins_reputation_bar = "Reputation bar" -- Need review
L.unitframe_plugins_reputation_bar_desc = "Attiva la barra reputazioni" -- Need review
L.unitframe_plugins_experience_bar = "Experience bar" -- Need review
L.unitframe_plugins_experience_bar_desc = "Attiva la barra esperienza" -- Need review
L.unitframe_plugins_artifact_bar = "Azerite Power bar" -- Need review
L.unitframe_plugins_artifact_bar_desc = "Barra potenza artefatto" -- Need review
L_GUI_UF_PLUGINS_SMOOTH_BAR = "Barra a cambiamento graduale"
L_GUI_UF_PLUGINS_ENEMY_SPEC = "Mostra la specializzazione dei talenti del nemico"
L_GUI_UF_PLUGINS_COMBAT_FEEDBACK = "Testo di combattimento sul riquadro del giocatore/bersaglio"
L_GUI_UF_PLUGINS_FADER = "Sfuma i riquadri delle unità"
L_GUI_UF_PLUGINS_DIMINISHING = "Diminuzione dell'effetto (diminishing return) sulle icone dei riquadri d'arena"
L_GUI_UF_PLUGINS_POWER_PREDICTION = "Previsione del costo in potere sulla barra del riquadro del giocatore"
L.unitframe_plugins_absorbs = "Absorbs value on player frame" -- Need review
L.unitframe_extra_height_auto = "Auto height for health/power" -- Need review
L.unitframe_extra_height_auto_desc = "Smart adjust depending on font size" -- Need review
L.unitframe_extra_health_height = "Additional height for health" -- Need review
L.unitframe_extra_power_height = "Additional height for power" -- Need review

-- Unit Frames Class bar options
L_GUI_UF_PLUGINS_CLASS_BAR = "Barre di classe"
L_GUI_UF_PLUGINS_CLASS_BAR_SUBTEXT = "Control of special class resources." -- Need review
L_GUI_UF_PLUGINS_COMBO_BAR = "Icone punti combo per druido e ladro"
L_GUI_UF_PLUGINS_COMBO_BAR_ALWAYS = "Mostra sempre la barra combo per il druido"
L_GUI_UF_PLUGINS_COMBO_BAR_OLD = "Mostra i punti combo sul bersaglio"
L_GUI_UF_PLUGINS_ARCANE_BAR = "Attiva la barra carica arcana"
L_GUI_UF_PLUGINS_CHI_BAR = "Attiva la barra di classe del monaco"
L_GUI_UF_PLUGINS_STAGGER_BAR = "Attiva la barra noncuranza (per i monaci difensori)"
L_GUI_UF_PLUGINS_HOLY_BAR = "Attiva la barra di classe del paladino"
L_GUI_UF_PLUGINS_SHARD_BAR = "Attiva la barra di classe dello stregone"
L_GUI_UF_PLUGINS_RUNE_BAR = "Attiva la barra di classe del cavaliere della morte"
L_GUI_UF_PLUGINS_TOTEM_BAR = "Attiva la barra dei totems dello sciamano"
L_GUI_UF_PLUGINS_RANGE_BAR = "Attiva la barra della distanza per i sacerdoti"

-- Raid Frames options
L_GUI_UF_RAIDFRAMES_SUBTEXT = "Customize the appearance of the raid frames." -- Need review
L_GUI_UF_BY_ROLE = "Suddividi i giocatori in gruppo a seconda del ruolo"
L_GUI_UF_AGGRO_BORDER = "Cambio di colore dei bordi in base al grado di aggressione"
L_GUI_UF_DEFICIT_HEALTH = "Deficit salute in incursione"
L_GUI_UF_SHOW_PARTY = "Mostra i riquadri del gruppo"
L_GUI_UF_SHOW_RAID = "Mostra i riquadri d'incursione"
L_GUI_UF_VERTICAL_HEALTH = "Orientamento verticale della salute"
L_GUI_UF_ALPHA_HEALTH = "Trasparenza delle barre della salute quando i punti sono al 100%"
L_GUI_UF_SHOW_RANGE = "Abilita l'opacità dei riquadri d'incursione in base alla distanza"
L_GUI_UF_RANGE_ALPHA = "Alpha" -- Need review
L_GUI_UF_RANGE_ALPHA_DESC = "Trasparenza dei riquadri delle unità quando un'unità è fuori portata"
L_GUI_UF_SUBHEADER_RAIDFRAMES = "Frames" -- Need review
L_GUI_UF_SOLO_MODE = "Mostra sempre il riquadro del giocatore"
L_GUI_UF_PLAYER_PARTY = "Mostra il riquadro del giocatore in gruppo"
L_GUI_UF_SHOW_TANK = "Mostra i difensori dell'incursione"
L_GUI_UF_SHOW_TANK_TT = "Mostra il bersaglio del bersaglio dei difensori dell'incursione"
L_GUI_UF_RAID_GROUP = "Numero dei gruppi nell'incursione"
L_GUI_UF_RAID_VERTICAL_GROUP = "Gruppi dell'incursione verticali (solo per la Disposizione da Guaritore)"
L_GUI_UF_SUBHEADER_ICONS = "Icons" -- Need review
L_GUI_UF_ICONS_ROLE = "Icona del ruolo sui riquadri"
L_GUI_UF_ICONS_RAID_MARK = "Marchi d'incursione"
L_GUI_UF_ICONS_READY_CHECK = "Icone dell'appello"
L_GUI_UF_ICONS_LEADER = "Icona del capoincursione, dell'assistente"
L_GUI_UF_ICONS_SUMON = "Icone d’evocazione sui riquadri"
L_GUI_UF_PLUGINS_DEBUFFHIGHLIGHT_ICON = "Evidenzia texture + icona delle penalità"
L_GUI_UF_PLUGINS_AURA_WATCH = "Icone delle penalità d'incursione"
L_GUI_UF_PLUGINS_AURA_WATCH_TIMER = "Timer sulle icone delle penalità d'incursione"
L_GUI_UF_PLUGINS_PVP_DEBUFFS = "Mostra anche un’icona per le penalità PvP (dall’elenco)"
L_GUI_UF_PLUGINS_HEALCOMM = "Mostra le cure in arrivo sul riquadro"
L.raidframe_plugins_auto_resurrection = "Auto cast resurrection" -- Need review
L.raidframe_plugins_auto_resurrection_desc = "'Auto-lancia' resurrezione col tasto centrale quando l'unità è morta (non funziona con Clique attiva)"
L.raidframe_hide_health_value = "Hide health value (only for heal layout)" -- Need review
L.raidframe_subheader_heal_size = "Size for heal layout" -- Need review
L.raidframe_heal_width = "Frame width" -- Need review
L.raidframe_heal_height = "Frame height" -- Need review
L.raidframe_heal_power_height = "Power height" -- Need review
L.raidframe_subheader_dps_size = "Size for dps layout" -- Need review
L.raidframe_dps_party_width = "Party width" -- Need review
L.raidframe_dps_party_height = "Party height" -- Need review
L.raidframe_dps_raid_width = "Raid width" -- Need review
L.raidframe_dps_raid_height = "Raid height" -- Need review
L.raidframe_dps_party_power_height = "Party power height" -- Need review
L.raidframe_dps_raid_power_height = "Raid power height" -- Need review


-- ActionBar options
L_GUI_ACTIONBAR = "Barre delle azioni"
L_GUI_ACTIONBAR_ENABLE = "Attiva le barre delle azioni"
L_GUI_ACTIONBAR_HOTKEY = "Mostra i nomi dei tasti di scelta rapida sugli scomparti"
L_GUI_ACTIONBAR_MACRO = "Mostra i nomi delle macro sugli scomparti"
L_GUI_ACTIONBAR_GRID = "Mostra lo sfondo degli scomparti vuoti sulle barre delle azioni"
L_GUI_ACTIONBAR_BUTTON_SIZE = "Dimensioni degli scomparti"
L_GUI_ACTIONBAR_BUTTON_SPACE = "Spazio tra gli scomparti"
L_GUI_ACTIONBAR_SPLIT_BARS = "Dividi la quinta barra in 2 barre da 6 scomparti ciascuna"
L_GUI_ACTIONBAR_CLASSCOLOR_BORDER = "Colora i bordi degli scomparti con i colori delle classi"
L.actionbar_toggle_mode = "Attiva la modalità a scomparsa"
L.actionbar_toggle_mode_desc = "The quick change in the number of panels. For the lower panels, hover the mouse over the hidden area above the panels. For right panels, hover the mouse over the area below the panels." -- Need review
L_GUI_ACTIONBAR_HIDE_HIGHLIGHT = "Nascondi il lumeggiare (highlight) di un proc."
L_GUI_ACTIONBAR_BOTTOMBARS = "Numero delle barre delle azioni in basso"
L_GUI_ACTIONBAR_RIGHTBARS = "Numero di barre delle azioni sulla destra"
L_GUI_ACTIONBAR_RIGHTBARS_MOUSEOVER = "Barre sulla destra al passaggio del mouse"
L_GUI_ACTIONBAR_PETBAR_HIDE = "Nascondi la barra famiglio"
L_GUI_ACTIONBAR_PETBAR_HORIZONTAL = "Rendi orizzontale la barra famiglio"
L_GUI_ACTIONBAR_PETBAR_MOUSEOVER = "Barra famiglio al passaggio del mouse (solo con la barra famiglio orizzontale)"
L_GUI_ACTIONBAR_STANCEBAR_HIDE = "Nascondi barra postura"
L_GUI_ACTIONBAR_STANCEBAR_HORIZONTAL = "Rendi orizzontale la barra postura"
L_GUI_ACTIONBAR_STANCEBAR_MOUSEOVER = "Barra postura al passaggio del mouse"
L_GUI_ACTIONBAR_MICROMENU = "Attiva il micromenu"
L_GUI_ACTIONBAR_MICROMENU_MOUSEOVER = "Micromenu al passaggio del mouse"

-- Tooltip options
L_GUI_TOOLTIP = "Suggerimenti"
L_GUI_TOOLTIP_SUBTEXT = "In this block, you can change the standard tips when mouseovering." -- Need review
L_GUI_TOOLTIP_ENABLE = "Attiva i suggerimenti"
L_GUI_TOOLTIP_SHIFT = "Mostra i suggerimenti quando è premuto il tasto Shift"
L_GUI_TOOLTIP_CURSOR = "Suggerimenti sopra il cursore"
L_GUI_TOOLTIP_ICON = "Icone degli oggetti nei suggerimenti"
L_GUI_TOOLTIP_HEALTH = "Valore numerico della salute"
L_GUI_TOOLTIP_HIDE = "Nascondi i suggerimenti relativi alle barre delle azioni"
L_GUI_TOOLTIP_HIDE_COMBAT = "Nascondi i suggerimenti in combattimento"
L_GUI_TOOLTIP_SUBHEADER_PLUGINS = "Plugins" -- Need review
L_GUI_TOOLTIP_TALENTS = "Mostra i talenti nei suggerimenti"
L_GUI_TOOLTIP_ACHIEVEMENTS = "Mostra il paragone delle imprese nei suggerimenti"
L_GUI_TOOLTIP_TARGET = "Mostra nei suggerimenti chi ha il giocatore come bersaglio"
L_GUI_TOOLTIP_TITLE = "Titolo del giocatore nei suggerimenti"
L_GUI_TOOLTIP_REALM = "Reame del giocatore nei suggerimenti"
L_GUI_TOOLTIP_RANK = "Rango in gilda nei suggerimenti"
L_GUI_TOOLTIP_ARENA_EXPERIENCE = "Esperienza PvP del giocatore in arena"
L_GUI_TOOLTIP_SPELL_ID = "ID Incantesimo/Abilità"
L_GUI_TOOLTIP_AVERAGE_LVL_DESC = "The average item level" -- Need review
L_GUI_TOOLTIP_RAID_ICON = "Visualizza i marchi d'incursione nei suggerimenti"
L_GUI_TOOLTIP_WHO_TARGETTING = "Visualizza chi ha in bersaglio l'unità che è nel tuo gruppo/incursione"
L_GUI_TOOLTIP_ITEM_COUNT = "Conteggio oggetti"
L_GUI_TOOLTIP_UNIT_ROLE = "Ruolo dell'unità"
L_GUI_TOOLTIP_INSTANCE_LOCK = "Info incursione nei suggerimenti"
L.tooltip_vendor_price = "Show vendor price" -- Needs review

-- Chat options
L_GUI_CHAT_SUBTEXT = "Here you can change the settings of the chat window." -- Need review
L_GUI_CHAT_ENABLE = "Attiva chat"
L_GUI_CHAT_BACKGROUND = "Attiva lo sfondo della chat"
L_GUI_CHAT_BACKGROUND_ALPHA = "Trasparenza sfondo della chat"
L_GUI_CHAT_SPAM = "Rimozione di un po' di spam di sistema ('Giocatore1' sconfigge 'Giocatore2' in un duello.)"
L_GUI_CHAT_GOLD = "Rimozione di un po' di spam degli altri giocatori"
L_GUI_CHAT_WIDTH = "Larghezza chat"
L_GUI_CHAT_HEIGHT = "Altezza chat"
L_GUI_CHAT_BAR = "Barra con pulsanti per passare velocemente da un canale all'altro della chat"
L_GUI_CHAT_BAR_MOUSEOVER = "Barra canali chat al passaggio del mouse"
L_GUI_CHAT_TIMESTAMP = "Colorazione orario dei messaggi"
L_GUI_CHAT_WHISP = "Suono quando ricevi un sussurro"
L_GUI_CHAT_SKIN_BUBBLE = "Restyling dei fumetti delle chats"
L_GUI_CHAT_CL_TAB = "Mostra la linguetta del Registro di combattimento"
L_GUI_CHAT_TABS_MOUSEOVER = "Linguette delle chats al passaggio del mouse"
L_GUI_CHAT_STICKY = "Ricorda l'ultimo canale"
L_GUI_CHAT_DAMAGE_METER_SPAM = "Riunisce lo spam di un contatore dei danni in un singolo link"

-- Nameplate options
L_GUI_NAMEPLATE_SUBTEXT = "Nameplate settings" -- Need review
L_GUI_NAMEPLATE_ENABLE = "Attiva le barre delle unità"
L_GUI_NAMEPLATE_COMBAT = "Mostra automaticamente le barre delle unità in combattimento"
L_GUI_NAMEPLATE_HEALTH = "Valore numerico della salute"
L_GUI_NAMEPLATE_DISTANCE = "Display range" -- Need review
L_GUI_NAMEPLATE_HEIGHT = "Altezza delle barre delle unità"
L_GUI_NAMEPLATE_WIDTH = "Larghezza delle barre delle unità"
L.nameplate_alpha = "Alpha" -- Needs review
L.nameplate_alpha_desc = "Non-target nameplate alpha" -- Needs review
L.nameplate_ad_height = "Additional height" -- Need review
L.nameplate_ad_width = "Additional width" -- Need review
L.nameplate_ad_height_desc = "Additional height for selected nameplate" -- Needs review
L.nameplate_ad_width_desc = "Additional width for selected nameplate" -- Needs review
L_GUI_NAMEPLATE_CASTBAR_NAME = "Mostra il nome di incantesimi/abilità sulle barre incantesimi"
L_GUI_NAMEPLATE_CLASS_ICON = "Icone delle classi in PvP"
L_GUI_NAMEPLATE_NAME_ABBREV = "Mostra nomi abbreviati"
L_GUI_NAMEPLATE_CLAMP = "Aggancia le barre delle unità in cima allo schermo quando sono fuori portata visiva"
L_GUI_NAMEPLATE_SHOW_DEBUFFS = "Mostra le penalità sulle barre delle unità (l'ozpione 'Mostra nomi abbreviati' deve essere disabilitata)"
L_GUI_NAMEPLATE_SHOW_BUFFS = "Mostra i benefici (da un elenco) sopra la barra la barra del giocatore"
L_GUI_NAMEPLATE_DEBUFFS_SIZE = "Dimensioni delle penalità sulle barre delle unità"
L_GUI_NAMEPLATE_HEALER_ICON = "Nei Campi di Battaglia, mostra un'icona 'guaritore' accanto alle barre delle unità di tutti i guaritori nemici"
L_GUI_NAMEPLATE_TOTEM_ICONS = "Mostra un’icona sopra la barra dei totem nemici"
L_GUI_NAMEPLATE_THREAT = "Attiva il sensore di rilevamento minaccia (si adatta automaticamente al tuo ruolo)"
L_GUI_NAMEPLATE_GOOD_COLOR = "Colore se il PG è minacciato (in base a difensore o assaltatore/guaritore)"
L_GUI_NAMEPLATE_NEAR_COLOR = "Colore per perdita/guadagno minaccia"
L_GUI_NAMEPLATE_BAD_COLOR = "Colore se il PG non è minacciato (se difensore o assaltatore/guaritore)"
L_GUI_NAMEPLATE_OFFTANK_COLOR = "Colore della minaccia per il difensore secondario"

-- Combat text options
L_GUI_COMBATTEXT = "Testo di combattimento"
L_GUI_COMBATTEXT_SUBTEXT = "For moving type in the chat '/xct'" -- Need review
L_GUI_COMBATTEXT_ENABLE = "Attiva il testo di combattimento"
L.combattext_blizz_head_numbers = "Enable Blizzard combat text" -- Need review
L.combattext_blizz_head_numbers_desc = "Usa il testo di combattimento della Blizzard per danni/cure"
L.combattext_damage_style = "Change default combat font" -- Need review
L.combattext_damage_style_desc = "Cambia il carattere di base per danni/cure (è necessario riavviare il gioco)"
L_GUI_COMBATTEXT_DAMAGE = "Mostra i danni in un proprio riquadro dedicato"
L_GUI_COMBATTEXT_HEALING = "Mostra le cure in un proprio riquadro dedicato"
L_GUI_COMBATTEXT_HOTS = "Mostra gli effetti delle cure periodiche nel riquadro delle cure"
L_GUI_COMBATTEXT_OVERHEALING = "Mostra le cure in eccesso"
L_GUI_COMBATTEXT_PET_DAMAGE = "Mostra i danni del tuo famiglio"
L_GUI_COMBATTEXT_DOT_DAMAGE = "Mostra i tuoi danni nel tempo"
L_GUI_COMBATTEXT_DAMAGE_COLOR = "Colora i numeri dei danni in base alla scuola di magia"
L_GUI_COMBATTEXT_CRIT_PREFIX = "Simbolo che sarà aggiunto prima dei critici"
L_GUI_COMBATTEXT_CRIT_POSTFIX = "Simbolo che sarà aggiunto dopo i critici"
L_GUI_COMBATTEXT_ICONS = "Mostra le icone dei danni"
L_GUI_COMBATTEXT_ICON_SIZE = "Icon size" -- Need review
L_GUI_COMBATTEXT_ICON_SIZE_DESC = "Dimensioni icone danni (influenza anche le dimensioni del carattere dei danni)"
L_GUI_COMBATTEXT_TRESHOLD = "Danno minimo da mostrare nel riquadro dei danni"
L_GUI_COMBATTEXT_HEAL_TRESHOLD = "Cure minime da mostrare nei messaggi delle cure"
L_GUI_COMBATTEXT_SCROLLABLE = "Attiva la 'modalità scorrimento': consente di scorrere tra le righe dei riquadri con la rotellina del mouse"
L_GUI_COMBATTEXT_MAX_LINES = "Max lines" -- Need review
L_GUI_COMBATTEXT_MAX_LINES_DESC = "Massimo numero righe da ricordare in 'scorrimento' (più righe = più memoria)"
L_GUI_COMBATTEXT_TIME_VISIBLE = "Time" -- Need review
L_GUI_COMBATTEXT_TIME_VISIBLE_DESC = "Tempo (in secondi) in cui un singolo messaggio sarà visibile"
L_GUI_COMBATTEXT_DK_RUNES = "Mostra la ricarica delle rune dei cavalieri della morte"
L_GUI_COMBATTEXT_KILLINGBLOW = "Comunica i tuoi colpi di grazia"
L_GUI_COMBATTEXT_MERGE_AOE_SPAM = "Unisci lo spam per danni multipli a più bersagli in un singolo messaggio"
L_GUI_COMBATTEXT_MERGE_MELEE = "Unifica lo spam di attacchi automatici multipli"
L_GUI_COMBATTEXT_DISPEL = "Comunica le tue dissoluzioni (dispels)"
L_GUI_COMBATTEXT_INTERRUPT = "Comunica le tue interruzioni (interrupts)"
L_GUI_COMBATTEXT_DIRECTION = "Change scrolling direction from bottom to top" -- Need review
L_GUI_COMBATTEXT_SHORT_NUMBERS = "Usa abbreviazioni numeriche ('25.3k' invece di '25342')"

-- Auras/Buffs/Debuffs
L_GUI_AURA_PLAYER_BUFF_SIZE = "Buffs size" -- Need review
L_GUI_AURA_PLAYER_BUFF_SIZE_DESC = "Dimensione benefici giocatore"
L_GUI_AURA_SHOW_SPIRAL = "Spirale trascorrere tempo sulle icone delle auree"
L_GUI_AURA_SHOW_TIMER = "Mostra il timer del recupero sulle icone delle auree"
L_GUI_AURA_PLAYER_AURAS = "Auree sul riquadro del giocatore"
L_GUI_AURA_TARGET_AURAS = "Auree sul riquadro del bersaglio"
L_GUI_AURA_FOCUS_DEBUFFS = "Penalità sul riquadro del focus"
L_GUI_AURA_FOT_DEBUFFS = "Penalità sul riquadro del bersaglio del focus"
L_GUI_AURA_PET_DEBUFFS = "Penalità sul riquadro del famiglio"
L_GUI_AURA_TOT_DEBUFFS = "Penalità sul riquadro del bersaglio del bersaglio"
L_GUI_AURA_BOSS_BUFFS = "Benefici sul riquadro del boss"
L_GUI_AURA_PLAYER_AURA_ONLY = "Mostra solo le tue penalità sul riquadro del bersaglio"
L_GUI_AURA_DEBUFF_COLOR_TYPE = "Colora le penalità a seconda del tipo"
L_GUI_AURA_CAST_BY = "Mostra chi ha lanciato un beneficio o una penalità nei suggerimenti"
L_GUI_AURA_CLASSCOLOR_BORDER = "Colora i bordi dei benefici del giocatore in base al colore della classi"

-- Bag options
L_GUI_BAGS = "Sacche"
L_GUI_BAGS_SUBTEXT = "Changing the built-in bags." -- Need review
L_GUI_BAGS_ENABLE = "Attiva le sacche"
L_GUI_BAGS_ILVL = "Mostra il livello oggetto di armi e armature"
L_GUI_BAGS_BUTTON_SIZE = "Dimensioni degli scomparti"
L_GUI_BAGS_BUTTON_SPACE = "Spazio tra gli scomparti"
L_GUI_BAGS_BANK = "Numero di colonne in banca"
L_GUI_BAGS_BAG = "Numero di colonne nella sacca principale"

-- Minimap options
L_GUI_MINIMAP_SUBTEXT = "Minimap settings." -- Need review
L_GUI_MINIMAP_ENABLE = "Attiva la minimappa"
L_GUI_MINIMAP_ICON = "Icona tracciamento"
L_GUI_GARRISON_ICON = "Icona della guarnigione"
L_GUI_MINIMAP_SIZE = "Dimensioni della minimappa"
L_GUI_MINIMAP_HIDE_COMBAT = "Nascondi la minimappa in combattimento"
L_GUI_MINIMAP_TOGGLE_MENU = "Mostra il menu a scomparsa"
L.minimap_bg_map_stylization = "Restyling della mappa dei Campi di Battaglia"
L.minimap_fog_of_war = "Nebbia della guerra sulla mappa del mondo"
L.minimap_fog_of_war_desc = "Right click on the close button of World Map to activate the option to hide fog of war" -- Need review

-- Loot options
L_GUI_LOOT_SUBTEXT = "Settings for loot frame." -- Need review
L_GUI_LOOT_ENABLE = "Attiva il riquadro bottino"
L_GUI_LOOT_ROLL_ENABLE = "Attiva il riquadro del bottino di gruppo"
L_GUI_LOOT_ICON_SIZE = "Dimensioni delle icone"
L_GUI_LOOT_WIDTH = "Larghezza del riquadro bottino"
L_GUI_LOOT_AUTOGREED = "A livello massimo, attiva automaticamente la bramosia per gli oggetti verdi"
L_GUI_LOOT_AUTODE = "'Auto-conferma' il disincantamento degli oggetti"
L.loot_faster_loot = "Faster looting" -- Need review
L.loot_faster_loot_desc = "Works only if enabled auto loot" -- Need review

-- Filger
L_GUI_FILGER = "Timers (Filger)"
L_GUI_FILGER_SUBTEXT = "Filger - analogue WeakAuras, but more simple and easy. Allows you to display in the form of icons and bars your auras and timers." -- Need review
L_GUI_FILGER_ENABLE = "Attiva Filger"
L_GUI_FILGER_TEST_MODE = "Modalità di prova delle icone"
L_GUI_FILGER_MAX_TEST_ICON = "Il numero di icone da sottoporre alla prova"
L_GUI_FILGER_SHOW_TOOLTIP = "Mostra suggerimenti"
L_GUI_FILGER_DISABLE_CD = "Disattiva i recuperi"
L_GUI_FILGER_DISABLE_PVP = "Disable PvP debuffs on Player and Target" -- Need review
L_GUI_FILGER_EXPIRATION = "Sort cooldowns by expiration time" -- Need review
L_GUI_FILGER_BUFFS_SIZE = "Dimensione dei benefici"
L_GUI_FILGER_COOLDOWN_SIZE = "Dimensione dei recuperi"
L_GUI_FILGER_PVP_SIZE = "Dimensione delle penalità PvP"

-- Announcements options
L_GUI_ANNOUNCEMENTS = "Annunci"
L_GUI_ANNOUNCEMENTS_SUBTEXT = "Settings that add chat announcements about spells or items." -- Need review
L_GUI_ANNOUNCEMENTS_DRINKING = "Annuncia in chat quando un nemico in arena sta bevendo"
L_GUI_ANNOUNCEMENTS_INTERRUPTS = "Annuncia in gruppo/incursione quando tu interrompi un incantesimo/abilità"
L_GUI_ANNOUNCEMENTS_SPELLS = "Annuncia in gruppo/incursione quando usi alcuni incantesimi/abilità"
L_GUI_ANNOUNCEMENTS_SPELLS_FROM_ALL = "Controlla incantesimi/abilità lanciati da tutti i compagni di gruppo/incursione"
L_GUI_ANNOUNCEMENTS_TOY_TRAIN = "Annuncia l'uso del Trenino Giocattolo o del Telecomando di Birranera"
L_GUI_ANNOUNCEMENTS_SAYS_THANKS = "Ringrazia per alcuni incantesimi/abilità"
L_GUI_ANNOUNCEMENTS_PULL_COUNTDOWN = "Annuncia il conto alla rovescia di avvio incontro '/pc #'"
L_GUI_ANNOUNCEMENTS_FLASK_FOOD = "Annuncia l'uso di tonici e cibo (/ffcheck)"
L_GUI_ANNOUNCEMENTS_FLASK_FOOD_RAID = "Annuncia l'uso di cibi e tonici nel canale incursione"
L_GUI_ANNOUNCEMENTS_FLASK_FOOD_AUTO = "Annuncia automaticamente l'uso di cibi e tonici all'appello"
L_GUI_ANNOUNCEMENTS_FEASTS = "Annuncia l'uso di tripudi/calderoni/anime/robots per le riparazioni"
L_GUI_ANNOUNCEMENTS_PORTALS = "Annuncia l'uso di un portale/Rituale d'Evocazione"
L_GUI_ANNOUNCEMENTS_BAD_GEAR = "Controlla l'equip. non idoneo in instance"
L_GUI_ANNOUNCEMENTS_SAFARI_HAT = "Controlla se il Cappello da Safari sia indossato o meno"

-- Automation options
L_GUI_AUTOMATION = "Automatismi"
L_GUI_AUTOMATION_SUBTEXT = "This block contains settings that facilitate the routine." -- Need review
L_GUI_AUTOMATION_DISMOUNT_STAND = "Auto dismount/stand" -- Needs review
L_GUI_AUTOMATION_RELEASE = "'Auto-risorgi' nei Campi di Battaglia"
L_GUI_AUTOMATION_SCREENSHOT = "Cattura una schermata quando completi un'impresa"
L.automation_solve_artifact = "Popup automatico restauro manufatto"
L.automation_solve_artifact_desc = "If there are enough fragments for an artifact, a popup will appear to solve it." -- Need review
L_GUI_AUTOMATION_ACCEPT_INVITE = "'Auto-accetta' gli inviti"
L_GUI_AUTOMATION_DECLINE_DUEL = "'Auto-declina' i duelli"
L_GUI_AUTOMATION_ACCEPT_QUEST = "'Auto-accetta' le missioni"
L_GUI_AUTOMATION_AUTO_COLLAPSE = "In instance, 'auto-chiudi' il tracciatore degli obiettivi"
L_GUI_AUTOMATION_AUTO_COLLAPSE_RELOAD = "Comprimi automaticamente l’ObjectiveTrackerFrame dopo un ricaricamento"
L_GUI_AUTOMATION_SKIP_CINEMATIC = "'Auto-salta' i filmati"
L_GUI_AUTOMATION_AUTO_ROLE = "'Auto-imposta' il tuo ruolo"
L_GUI_AUTOMATION_CANCEL_BAD_BUFFS = "'Auto-cancella' alcuni benefici"
L.automation_tab_binder = "Usando il tasto TAB, consente di prendere come bersaglio soltanto nemici controllati da altri giocatori (se presenti)"
L.automation_tab_binder_desc = "'Tab' key target only enemy players when in PvP zones, ignores pets and mobs" -- Need review
L_GUI_AUTOMATION_LOGGING_COMBAT = "In instances da incursione, 'auto-attiva' la registrazione del Registro di combattimento in un file di testo"
L.automation_buff_on_scroll = "Lancia benefici con la rotellina del mouse"
L.automation_buff_on_scroll_desc = "If the buff from the list is not applied to the player, it will cast by the mouse scroll" -- Need review
L_GUI_AUTOMATION_OPEN_ITEMS = "Apertura automatica degli oggetti nelle sacche"
L.automation_invite_keyword = "Parola chiave per invitare"
L.automation_invite_keyword_desc = "When player whisper you keyword he will be invited in your group. \nFor enable - type '/ainv'. Also after the command, you can write your word '/ainv inv'" -- Need review

-- Buffs reminder options
L_GUI_REMINDER = "Promemoria benefici"
L_GUI_REMINDER_SUBTEXT = "Display of missed auras." -- Need review
L_GUI_REMINDER_SOLO_ENABLE = "Mostra i propri benefici mancanti"
L_GUI_REMINDER_SOLO_SOUND = "Attiva un suono d'avviso per il promemoria dei propri benefici mancanti"
L_GUI_REMINDER_SOLO_SIZE = "Icon size" -- Need review
L_GUI_REMINDER_SOLO_SIZE_DESC = "Dimensione dell'icona dei propri benefici"
L_GUI_REMINDER_SUBHEADER = "Raid buffs" -- Need review
L_GUI_REMINDER_RAID_ENABLE = "Mostra i benefici d'incursione mancanti"
L_GUI_REMINDER_RAID_ALWAYS = "Mostra sempre il promemoria benefici"
L_GUI_REMINDER_RAID_SIZE = "Icon size" -- Need review
L_GUI_REMINDER_RAID_SIZE_DESC = "Dimensioni delle icone del promemoria benefici d'incursione"
L_GUI_REMINDER_RAID_ALPHA = "Transparent" -- Need review
L_GUI_REMINDER_RAID_ALPHA_DESC = "Trasparenza icona quando il beneficio è presente"

-- Raid cooldowns options
L_GUI_COOLDOWN_RAID = "Recuperi d'incursione"
L_GUI_COOLDOWN_RAID_SUBTEXT = "Tracking raid abilities in the upper left corner." -- Need review
L_GUI_COOLDOWN_RAID_ENABLE = "Visualizza i recuperi d'incursione"
L_GUI_COOLDOWN_RAID_HEIGHT = "Bars height" -- Need review
L_GUI_COOLDOWN_RAID_WIDTH = "Bars width" -- Need review
L_GUI_COOLDOWN_RAID_SORT = "Disposizione verso l'alto delle barre dei recuperi d'incursione"
L_GUI_COOLDOWN_RAID_EXPIRATION = "Ordina in base al tempo di scadenza"
L_GUI_COOLDOWN_RAID_SHOW_SELF = "Mostra i miei recuperi"
L_GUI_COOLDOWN_RAID_ICONS = "Icone dei recuperi d'incursione"
L_GUI_COOLDOWN_RAID_IN_RAID = "Mostra i recuperi d'incursione nelle aree da incursione"
L_GUI_COOLDOWN_RAID_IN_PARTY = "Mostra i recuperi d'incursione nelle aree da gruppo"
L_GUI_COOLDOWN_RAID_IN_ARENA = "Mostra i recuperi d'incursione nelle aree da arena"

-- Enemy cooldowns options
L_GUI_COOLDOWN_ENEMY = "Recuperi del nemico"
L_GUI_COOLDOWN_ENEMY_SUBTEXT = "Tracking enemy abilities as icons above your spell casting bar." -- Need review
L_GUI_COOLDOWN_ENEMY_ENABLE = "Visualizza i recuperi del nemico"
L_GUI_COOLDOWN_ENEMY_SIZE = "Dimensioni delle icone dei recuperi del nemico"
L_GUI_COOLDOWN_ENEMY_DIRECTION = "Direzione icone recuperi del nemico"
L_GUI_COOLDOWN_ENEMY_EVERYWHERE = "Mostra i recuperi del nemico in qualsiasi area"
L_GUI_COOLDOWN_ENEMY_IN_BG = "Mostra i recuperi del nemico nelle aree da Campo di Battaglia"
L_GUI_COOLDOWN_ENEMY_IN_ARENA = "Mostra i recuperi del nemico nelle aree da arena"

-- Pulse cooldowns options
L_GUI_COOLDOWN_PULSE = "Recuperi effetto 'pulse'"
L_GUI_COOLDOWN_PULSE_SUBTEXT = "Track your cd using a pulse icon in the center of the screen." -- Need review
L_GUI_COOLDOWN_PULSE_ENABLE = "Mostra i recuperi con effetto 'pulse'"
L_GUI_COOLDOWN_PULSE_SIZE = "Dimensione dell'icona dei recuperi con effetto 'pulse'"
L_GUI_COOLDOWN_PULSE_SOUND = "Attiva un suono di avviso"
L_GUI_COOLDOWN_PULSE_ANIM_SCALE = "Regolazione dell'animazione"
L_GUI_COOLDOWN_PULSE_HOLD_TIME = "Opacità del tempo d'attesa massimo"
L_GUI_COOLDOWN_PULSE_THRESHOLD = "Threshold time" -- Need review
L_GUI_COOLDOWN_PULSE_THRESHOLD_DESC = "Soglia di tempo minimo"

-- Threat options
L_GUI_THREAT = "Barre di minaccia"
L_GUI_THREAT_SUBTEXT = "Display of the threat list (a simple analogue of Omen)." -- Need review
L_GUI_THREAT_ENABLE = "Attiva le barre di minaccia"
L_GUI_THREAT_HEIGHT = "Altezza delle barre di minaccia"
L_GUI_THREAT_WIDTH = "Larghezza delle barre di minaccia"
L_GUI_THREAT_ROWS = "Numero delle barre di minaccia"
L_GUI_THREAT_HIDE_SOLO = "Mostra soltanto in gruppo/incursione"

-- Top panel options
L_GUI_TOP_PANEL = "Pannello superiore"
L_GUI_TOP_PANEL_SUBTEXT = "Manage built-in top panel with information." -- Need review
L_GUI_TOP_PANEL_ENABLE = "Attiva il pannello superiore"
L_GUI_TOP_PANEL_MOUSE = "Pannello superiore al passaggio del mouse"
L_GUI_TOP_PANEL_WIDTH = "Larghezza pannello"
L_GUI_TOP_PANEL_HEIGHT = "Altezza pannello"

-- Stats options
L_GUI_STATS = "Stats"
L_GUI_STATS_SUBTEXT = "Statistics blocks located at the bottom of the screen. Type in the chat '/ls' for info." -- Need review
L_GUI_STATS_CLOCK = "Orologio"
L_GUI_STATS_LATENCY = "Latenza"
L_GUI_STATS_FPS = "Frames Per Seconds"
L_GUI_STATS_EXPERIENCE = "Esperienza"
L_GUI_STATS_TALENTS_DESC = "Date-text allows you to change the spec and loot on click" -- Need review
L_GUI_STATS_COORDS = "Coordinate"
L_GUI_STATS_LOCATION = "Località"
L_GUI_STATS_BG = "Campi di Battaglia"
L_GUI_STATS_SUBHEADER_CURRENCY = "Currency (displayed in gold data text)" -- Need review
L_GUI_STATS_CURRENCY_ARCHAEOLOGY = "Mostra i frammenti di archeologia sotto la linguetta della valuta"
L_GUI_STATS_CURRENCY_COOKING = "Mostra le ricompense di cucina sotto la linguetta della valuta"
L_GUI_STATS_CURRENCY_PROFESSIONS = "Mostra i gettoni delle professioni sotto la linguetta della valuta"
L_GUI_STATS_CURRENCY_RAID = "Mostra i sigilli delle incursioni"

-- Error options
L_GUI_ERROR = "Errori"
L_GUI_ERROR_SUBTEXT = "Filtering standard text at the top of the screen from Blizzard." -- Need review
L_GUI_ERROR_BLACK = "Nascondi gli errori della lista nera"
L_GUI_ERROR_WHITE = "Mostra gli errori della lista bianca"
L_GUI_ERROR_HIDE_COMBAT = "In combattimento, nascondi tutti gli errori"

-- Miscellaneous options
L_GUI_MISC_SUBTEXT = "Other settings that add interesting features." -- Need review
L.misc_max_camera_distance = "Increase camera distance to max on login" -- Needs review
L.misc_shift_marking = "Marks mouseover target" -- Need review
L.misc_shift_marking_desc = "Marks mouseover target when you push Shift (only in group)" -- Need review
L_GUI_MISC_SPIN_CAMERA = "Ruota la camera mentre sei assente"
L_GUI_MISC_VEHICLE_MOUSEOVER = "Riquadro veicolo al passaggio del mouse"
L_GUI_MISC_QUEST_AUTOBUTTON = "Pulsante automatico missione/oggetto"
L.misc_raid_tools = "Strumenti per le incursioni"
L.misc_raid_tools_desc = "Button at the top of the screen for ready check (Left-click), checking roles (Middle-click), setting marks, etc. (for leader and assistants)" -- Need review
L_GUI_MISC_PROFESSION_TABS = "Visualizza la linguetta delle professioni sul riquadro abilità di commercio/commercio"
L_GUI_MISC_HIDE_BG_SPAM = "Rimuovi lo spam delle emotes dei bosses durante i Campi di Battaglia"
L.misc_hide_bg_spam_desc = "Remove Boss Emote spam about capture/losing node during BG Arathi and Gilneas" -- Need review
L_GUI_MISC_ITEM_LEVEL = "Livello oggetto sugli scomparti della schermata Personaggio"
L_GUI_MISC_ALREADY_KNOWN = "Colora ricette/cavalcature/mascottes possedute"
L_GUI_MISC_DISENCHANTING = "Disincantamento, Pestatura e Prospezione in un solo click"
L.misc_sum_buyouts = "Somma assieme tutte le aste correnti"
L.misc_sum_buyouts_desc = "At auctions tab shows sum up all current auctions" -- Need review
L.misc_click_cast = "Scorciatoie da mouse (Click2Cast)"
L.misc_click_cast_desc = "Allows you to assign spells (analog Clique) to the mouse buttons. Setup through the side bookmark in the spell book" -- Need review
L.misc_click_cast_filter = "Ignora i riquadri di giocatore e bersaglio con Click2Cast"
L_GUI_MISC_MOVE_BLIZZARD = "Consenti di muovere alcuni riquadri dell'interfaccia Blizzard"
L.misc_color_picker = "Selezionatore colore migliorato"
L.misc_color_picker_desc = "Add copy/paste buttons and digit text entry for Blizzard color picker frame" -- Need review
L_GUI_MISC_ENCHANTMENT_SCROLL = "Pergamena Incantamento sul riquadro sul riquadro abilità di commercio"
L.misc_archaeology = "Archeologia: reliquie e recuperi"
L.misc_archaeology_desc = "Archaeology tracker ('/arch' or right mouseover minimap button to show)" -- Need review
L.misc_chars_currency = "Traccia la valuta complessiva posseduta dai tuoi personaggi"
L.misc_chars_currency_desc = "Hover over the icon of the required currency in the character window to display information in the tooltip" -- Need review
L.misc_armory_link = "Add Armory link" -- Need review
L.misc_armory_link_desc = "Aggiungi un collegamento all’Armeria nei menu a comparsa delle unità (ciò disattiva alcune voci nei menu)"
L_GUI_MISC_MERCHANT_ITEMLEVEL = "Mostra il livello dell’oggetto di armi e armature in vendita"
L_GUI_MISC_MINIMIZE_MOUSEOVER = "Pulsante per minimizzare le missioni al passaggio del mouse"
L_GUI_MISC_HIDE_BANNER = "Nascondi il Boss Banner Loot Frame"
L_GUI_MISC_HIDE_TALKING_HEAD = "Nascondi il Talking Head Frame"
L.misc_hide_raid_button = "Nascondi il pulsante di oUF_RaidDPS"
L.misc_hide_raid_button_desc = "The button is displayed by hovering the mouse in the upper left corner" -- Need review
