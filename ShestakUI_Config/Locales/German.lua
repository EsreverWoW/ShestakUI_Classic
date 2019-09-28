local _, L = ...
if GetLocale() ~= "deDE" then return end

----------------------------------------------------------------------------------------
--	Localization for deDE client
--	Translation: Alwa, Baine, Chubidu, Vienchen
----------------------------------------------------------------------------------------
L_GUI_SET_SAVED_SETTTINGS = "Einstellungen für jeden Charakter einzeln vornehmen"
L_GUI_SET_SAVED_SETTTINGS_DESC = "Switch between a profile that applies to all characters and one that is unique to this character." -- Need review
L_GUI_RESET_CHAR = "Bist du sicher, dass du die Charaktereinstellungen für ShestakUI zurücksetzen willst?"
L_GUI_RESET_ALL = "Bist du sicher, dass du alle Einstellungen von ShestakUI zurücksetzen willst?"
L_GUI_PIXEL_FONT_CHAR = "Are you sure you want to reset your character's font settings to the pixel font style?" -- Need review
L_GUI_PIXEL_FONT_ALL = "Are you sure you want to reset all of your font settings to the pixel font style?" -- Need review
L_GUI_NORMAL_FONT_CHAR = "Are you sure you want to reset your character's font settings to the normal font style?" -- Need review
L_GUI_NORMAL_FONT_ALL = "Are you sure you want to reset all of your font settings to the normal font style?" -- Need review
L_GUI_PER_CHAR = "Bist du sicher, dass du 'Einzelne Einstellungen für jeden Charakter' ein oder ausschalten möchtest?"
L_GUI_NEED_RELOAD = "|cffff2735Benutzeroberfläche erneut laden, um Ihre Änderungen zu übernehmen.|r"

-- General options
L_GUI_GENERAL_SUBTEXT = "Diese Einstellungen steuern die allgemeinen Einstellungen der Benutzeroberfläche. Geben Sie im Chat '/uihelp ein, um Hilfe zu erhalten."
L_GUI_GENERAL_WELCOME_MESSAGE = "Welcome message in chat"
L_GUI_GENERAL_AUTOSCALE = "Automatisch UI skalieren"
L_GUI_GENERAL_UISCALE = "UI Skalierung (falls automatische Skalierung deaktiviert)"
L_GUI_GENERAL_BOTTOMLINES = "Show Bottom Panel Lines" -- Need review
L.general_subheader_font_style = "Global font style (presets which overwrite individual font settings)" -- Need review
L.media_border_color = "Farbe für Rahmen"
L.media_backdrop_color = "Farbe für Rahmen-Hintergrund"
L.media_backdrop_alpha = "Alpha für transparenten Hintergrund"
L.media_subheader_pixel = "Ändere Pixel Font"

-- Font options
L.font = "Schriftart"
L.font_subtext = "Anpassen der einzelne Schriftarten für Elemente."
L.font_stats_font = "Schriftart auswählen"
L.font_stats_font_style = "Schriftart Flag"
L.font_stats_font_shadow = "Schriftart Schatten"
L.font_subheader_stats = "Stats Schriftart"
L.font_subheader_combat = "Combat Text Schriftart"
L.font_subheader_chat = "Chat Text Schriftart"
L.font_subheader_chat_tabs = "Chat Tabs Schriftart"
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
L_GUI_SKINS = "Design/Skins"
L_GUI_SKINS_SUBTEXT = "Ändert das Erscheinungsbild der Standard UI."
L_GUI_SKINS_BLIZZARD = "Aktiviere Styles für Blizzardfenster"
L_GUI_SKINS_MINIMAP_BUTTONS = "Aktiviere styling Addonincons an der Minimap"
L_GUI_SKINS_SUBHEADER = "Design/Skins für Addons"
L_GUI_SKINS_DBM_MOVABLE = "Erlaube das bewegen der DBM Leisten"

-- Unit Frames options
L_GUI_UF_SUBTEXT = "Customize player, target frames and etc." -- Need review
L_GUI_UF_ENABLE = "Unitframes aktivieren"
L_GUI_UF_OWN_COLOR = "Farbe für die Lebensleiste festlegen"
L_GUI_UF_UF_COLOR = "Farbe der Gesundheitsleiste (falls eigene Farbe verwender wird)"
L_GUI_UF_ENEMY_HEALTH_COLOR = "Lebensleiste eines gegnerischen Ziels ist rot"
L_GUI_UF_TOTAL_VALUE = "Zeige Infotext auf Spieler und Ziel mit XXX/Gesamt"
L_GUI_UF_COLOR_VALUE = "Lebens/Mana Werte einfärben"
L_GUI_UF_BAR_COLOR_VALUE = "Lebensbalken nach vorhandenem Leben einfärben"
L_GUI_UF_LINES = "Zeige Spieler & Ziel Extra Linien an"
L_GUI_UF_PLAYER_NAME = "Show player's name and level" -- Needs review
L_GUI_UF_BAR_COLOR_HAPPINESS = "Color pet health bar by happiness" -- Needs review
L_GUI_UF_SUBHEADER_CAST = "Zauberleiste"
L_GUI_UF_UNIT_CASTBAR = "Zeige Zauberleisten"
L_GUI_UF_CASTBAR_ICON = "Zeige Symbole der Zauberleisten an"
L_GUI_UF_CASTBAR_LATENCY = "Latenz in Zauberleiste anzeigen"
L_GUI_UF_CASTBAR_TICKS = "Castbar Ticks"
L_GUI_UF_SUBHEADER_FRAMES = "Frames/Einheitenfenster"
L_GUI_UF_SHOW_PET = "Zeige Begleiterfenster an"
L_GUI_UF_SHOW_FOCUS = "Zeige Fokusfenster an"
L_GUI_UF_SHOW_TOT = "Zeige 'Ziel des Ziels' Fenster an"
L_GUI_UF_SHOW_BOSS = "Zeige Bossfenster"
L_GUI_UF_BOSS_RIGHT = "Bossfenster rechts"
L_GUI_UF_SHOW_ARENA = "Zeige Arenafenster"
L_GUI_UF_ARENA_RIGHT = "Arenafenster Rechts"
L_GUI_UF_BOSS_DEBUFFS = "Anzahl der Debuffs"
L_GUI_UF_BOSS_DEBUFFS_DESC = "Anzahl der Debuffs am Boss Frames"
L_GUI_UF_BOSS_BUFFS = "Anzahl der Buffs"
L_GUI_UF_BOSS_BUFFS_DESC = "Anzahl der Buffs am Boss Frames"
L_GUI_UF_ICONS_PVP = "Zeige PvP Text (keine Symbole) bei Mouseover (Spieler+Ziel)"
L_GUI_UF_ICONS_COMBAT = "Kampfsymbol"
L_GUI_UF_ICONS_RESTING = "Ausruhensymbol für low-lvl Chars"
L_GUI_UF_SUBHEADER_PORTRAIT = "Portraits"
L_GUI_UF_PORTRAIT_ENABLE = "Aktiviere Spieler/Ziel Portraits"
L_GUI_UF_PORTRAIT_CLASSCOLOR_BORDER = "Aktiviere Rahmen in Klassenfarbe"
L_GUI_UF_PORTRAIT_HEIGHT = "Portraithöhe"
L_GUI_UF_PORTRAIT_WIDTH = "Portraitbreite"
L_GUI_UF_SUBHEADER_PLUGINS = "Plugins"
L_GUI_UF_PLUGINS_GCD = "Blitz für globalen Cooldown"
L_GUI_UF_PLUGINS_ENERGY_TICKER = "Enable energy ticker" -- Needs review
L_GUI_UF_PLUGINS_SWING = "Swingleiste"
L.unitframe_plugins_reputation_bar = "Rufleiste"
L.unitframe_plugins_reputation_bar_desc = "Rufleiste"
L.unitframe_plugins_experience_bar = "Erfahrungsleiste"
L.unitframe_plugins_experience_bar_desc = "Erfahrungsleiste"
L.unitframe_plugins_artifact_bar = "Azerite Power Leiste"
L.unitframe_plugins_artifact_bar_desc = "Artifact Power Leiste"
L_GUI_UF_PLUGINS_SMOOTH_BAR = "Weichgezeichnete Leisten"
L_GUI_UF_PLUGINS_ENEMY_SPEC = "Zeige gegnerische Talente"
L_GUI_UF_PLUGINS_COMBAT_FEEDBACK = "Kampftexts auf Spieler/Zielfenster"
L_GUI_UF_PLUGINS_FADER = "Blende Einheitenfenster aus"
L_GUI_UF_PLUGINS_DIMINISHING = "Diminishing Returns Symbole auf Arena Fenstern"
L_GUI_UF_PLUGINS_POWER_PREDICTION = "Power cost prediction bar on player frame" -- Need review
L.unitframe_plugins_absorbs = "Absorbs value on player frame" -- Need review
L.unitframe_extra_height_auto = "Auto height for health/power" -- Need review
L.unitframe_extra_height_auto_desc = "Smart adjust depending on font size" -- Need review
L.unitframe_extra_health_height = "Additional height for health" -- Need review
L.unitframe_extra_power_height = "Additional height for power" -- Need review

-- Unit Frames Class bar options
L_GUI_UF_PLUGINS_CLASS_BAR = "Unit Frames Klassenleisten"
L_GUI_UF_PLUGINS_CLASS_BAR_SUBTEXT = "Control of special class resources." -- Need review
L_GUI_UF_PLUGINS_COMBO_BAR = "Symbole für Schurke/Druide Combopunkte"
L_GUI_UF_PLUGINS_COMBO_BAR_ALWAYS = "Zeige immer die Combo Leiste für Druiden"
L_GUI_UF_PLUGINS_COMBO_BAR_OLD = "Zeige Combopunkte auf dem Ziel"
L_GUI_UF_PLUGINS_ARCANE_BAR = "Aktiviere Arcane Charge Leiste"
L_GUI_UF_PLUGINS_CHI_BAR = "Ativiere Chi Leiste"
L_GUI_UF_PLUGINS_STAGGER_BAR = "Aktiviere Stagger Leiste (für Monk Tanks)"
L_GUI_UF_PLUGINS_HOLY_BAR = "Aktivere Heilige Kraft Leiste"
L_GUI_UF_PLUGINS_SHARD_BAR = "Aktiviere Splitter Leiste"
L_GUI_UF_PLUGINS_RUNE_BAR = "Runenleiste"
L_GUI_UF_PLUGINS_TOTEM_BAR = "Totemleiste"
L_GUI_UF_PLUGINS_RANGE_BAR = "Aktiviere Abstandsleiste"

-- Raid Frames options
L_GUI_UF_RAIDFRAMES_SUBTEXT = "Customize the appearance of the raid frames." -- Need review
L_GUI_UF_BY_ROLE = "Sortierung der Gruppenspieler nach Rolle"
L_GUI_UF_AGGRO_BORDER = "Rahmen bei Bedrohung"
L_GUI_UF_DEFICIT_HEALTH = "Fehlendes Leben im Raid"
L_GUI_UF_SHOW_PARTY = "Zeige Gruppenfenster"
L_GUI_UF_SHOW_RAID = "Zeige Raidfenster"
L_GUI_UF_VERTICAL_HEALTH = "Vertikale Orientierung für Lebensbalken"
L_GUI_UF_ALPHA_HEALTH = "Transparenz der Lebensbalken wenn 100% Leben"
L_GUI_UF_SHOW_RANGE = "Raidframes durchsichtig abhängig von der Entfernung"
L_GUI_UF_RANGE_ALPHA = "Alpha" -- Need review
L_GUI_UF_RANGE_ALPHA_DESC = "Einheitenfenster zu diesem Maß ausblenden wenn außer Reichweite"
L_GUI_UF_SUBHEADER_RAIDFRAMES = "Frames" -- Need review
L_GUI_UF_SOLO_MODE = "Spielerfenster immer Anzeigen"
L_GUI_UF_PLAYER_PARTY = "Spielerfenster in der Gruppe anzeigen"
L_GUI_UF_SHOW_TANK = "Zeige Raid Tanks an"
L_GUI_UF_SHOW_TANK_TT = "Zeige Ziel des Raid Tank Ziels (Ziel des Ziels)"
L_GUI_UF_RAID_GROUP = "Anzahl der Gruppen im Raid"
L_GUI_UF_RAID_VERTICAL_GROUP = "Vertikale Raidgruppen(Heiler Layout)"
L_GUI_UF_SUBHEADER_ICONS = "Icons"
L_GUI_UF_ICONS_ROLE = "Rollensymbol auf den Unit Frames"
L_GUI_UF_ICONS_RAID_MARK = "Raidsymbole"
L_GUI_UF_ICONS_READY_CHECK = "Bereitschaftschecksymbole"
L_GUI_UF_ICONS_LEADER = "Anführer/Assistent an den Fenstern anzeigen"
L_GUI_UF_ICONS_SUMON = "Sumon icons on frames" -- Need review
L_GUI_UF_PLUGINS_DEBUFFHIGHLIGHT_ICON = "Debufftextur und Symbol hervorheben"
L_GUI_UF_PLUGINS_AURA_WATCH = "'RAID' Buffüberwachung"
L_GUI_UF_PLUGINS_AURA_WATCH_TIMER = "Timer auf Schlachtzugsdebuff Icons"
L_GUI_UF_PLUGINS_PVP_DEBUFFS = "Zeige ebenfalls PvP Debuff Symbol (aus der Liste)"
L_GUI_UF_PLUGINS_HEALCOMM = "Leiste für Eingehende Heilung"
L.raidframe_plugins_auto_resurrection = "Auto cast resurrection" -- Need review
L.raidframe_plugins_auto_resurrection_desc = "Mittel-Klick um automatisch Auferstehung zu zauber wenn das Ziel tot ist (funktioniert nicht wenn Clique installiert ist)"
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
L_GUI_ACTIONBAR = "Aktionsleisten"
L_GUI_ACTIONBAR_ENABLE = "Aktionsleisten aktivieren"
L_GUI_ACTIONBAR_HOTKEY = "Zeige Hotkey-Text an"
L_GUI_ACTIONBAR_MACRO = "Zeige Makronamen auf den Buttons"
L_GUI_ACTIONBAR_GRID = "Zeige die leeren Knöpfe der Aktionsleisten an"
L_GUI_ACTIONBAR_BUTTON_SIZE = "Knopfgröße"
L_GUI_ACTIONBAR_BUTTON_SPACE = "Buttonabstand"
L_GUI_ACTIONBAR_SPLIT_BARS = "Splitte die Fünfte Aktionsleiste im zwei 6 Knöpfe Leisten"
L_GUI_ACTIONBAR_CLASSCOLOR_BORDER = "Aktiviere Klassenfarbe für Aktionsleisten"
L.actionbar_toggle_mode = "Aktiviere 'toggle mode'"
L.actionbar_toggle_mode_desc = "The quick change in the number of panels. For the lower panels, hover the mouse over the hidden area above the panels. For right panels, hover the mouse over the area below the panels." -- Need review
L_GUI_ACTIONBAR_HIDE_HIGHLIGHT = "hebe keine Procs hervor"
L_GUI_ACTIONBAR_BOTTOMBARS = "Anzahl der Aktionsleisten an der unteren Seite"
L_GUI_ACTIONBAR_RIGHTBARS = "Anzahl der Aktionsleisten an der rechten Seite"
L_GUI_ACTIONBAR_RIGHTBARS_MOUSEOVER = "Zeige die rechten Leisten nur bei Mouseover"
L_GUI_ACTIONBAR_PETBAR_HIDE = "Verstecke Begleiterleiste"
L_GUI_ACTIONBAR_PETBAR_HORIZONTAL = "Aktiviere horizontale Begleiterleiste"
L_GUI_ACTIONBAR_PETBAR_MOUSEOVER = "Zeige die Begleiterleiste nur bei Mouseover(nur für horizontale Begleiterleiste)"
L_GUI_ACTIONBAR_STANCEBAR_HIDE = "Gestaltenleiste verstecken"
L_GUI_ACTIONBAR_STANCEBAR_HORIZONTAL = "Horizontale Haltungsleiste aktivieren"
L_GUI_ACTIONBAR_STANCEBAR_MOUSEOVER = "Zeige Haltungsleiste/Gestaltenleiste nur bei Mouseover"
L_GUI_ACTIONBAR_MICROMENU = "Zeige Micromenü"
L_GUI_ACTIONBAR_MICROMENU_MOUSEOVER = "Micromenü bei MouseOver"

-- Tooltip options
L_GUI_TOOLTIP = "Tooltip"
L_GUI_TOOLTIP_SUBTEXT = "In this block, you can change the standard tips when mouseovering." -- Need review
L_GUI_TOOLTIP_ENABLE = "Aktiviere Tooltip"
L_GUI_TOOLTIP_SHIFT = "Tooltip anzeigen wenn 'Umschalttaste' gedrückt wird"
L_GUI_TOOLTIP_CURSOR = "Tooltip unter dem Mauszeiger öffnen"
L_GUI_TOOLTIP_ICON = "Symbol der Gegenstände im Tooltip anzeigen"
L_GUI_TOOLTIP_HEALTH = "Numerischer Wert der Lebenspunkte"
L_GUI_TOOLTIP_HIDE = "Tooltips für Aktionsleisten verstecken"
L_GUI_TOOLTIP_HIDE_COMBAT = "Verstecke Tooltip im Kampf"
L_GUI_TOOLTIP_SUBHEADER_PLUGINS = "Plugins"
L_GUI_TOOLTIP_TALENTS = "Zeige die Talente im Tooltip an"
L_GUI_TOOLTIP_ACHIEVEMENTS = "Verlgeichen von Erfolgen in Tooltips"
L_GUI_TOOLTIP_TARGET = "Ziel des Spielers im Tooltip anzeigen"
L_GUI_TOOLTIP_TITLE = "Spieler Title im Tooltip"
L_GUI_TOOLTIP_REALM = "Spieler Realm Name im Tooltip"
L_GUI_TOOLTIP_RANK = "Gildenrank im Tooltip anzeigen"
L_GUI_TOOLTIP_ARENA_EXPERIENCE = "PvP-Erfahrung des Spielers im Tooltip anzeigen (Arena)"
L_GUI_TOOLTIP_SPELL_ID = "Zauber ID"
L_GUI_TOOLTIP_AVERAGE_LVL_DESC = "Der durchschnittliche Item Level (GS)"
L_GUI_TOOLTIP_RAID_ICON = "Raidsymbol"
L_GUI_TOOLTIP_WHO_TARGETTING = "Zeige an, wer die Eihneit, die in deiner Gruppe/Raid ist, ins Ziel nimmt"
L_GUI_TOOLTIP_ITEM_COUNT = "Gegenstandsanzahl"
L_GUI_TOOLTIP_UNIT_ROLE = "Klassenrolle (Tank/Schaden/Heiler)"
L_GUI_TOOLTIP_INSTANCE_LOCK = "Deine abgeschlossenen Instanzen im Tooltip"
L.tooltip_vendor_price = "Show vendor price" -- Needs review

-- Chat options
L_GUI_CHAT_SUBTEXT = "Hier Einstellungen des Chat-Fensters ändern."
L_GUI_CHAT_ENABLE = "Chat aktivieren"
L_GUI_CHAT_BACKGROUND = "Chathintergrund aktivieren"
L_GUI_CHAT_BACKGROUND_ALPHA = "Transparenz des Hintergrunds"
L_GUI_CHAT_SPAM = "Entferne Systemspam ('Player1' gewinnt Duell 'Player2')"
L_GUI_CHAT_GOLD = "Entferne einigen Spam vom Server"
L_GUI_CHAT_WIDTH = "Breite des Chatfensters"
L_GUI_CHAT_HEIGHT = "Höhe desChatfensters"
L_GUI_CHAT_BAR = "Kleine Leiste um den Chatchannel zu wechseln"
L_GUI_CHAT_BAR_MOUSEOVER = "Aktionsleiste bei Mousover hervorheben"
L_GUI_CHAT_TIMESTAMP = "Farbe des Zeitstempels"
L_GUI_CHAT_WHISP = "Geräusch abspielen wenn eine private Nachricht empfangen wird"
L_GUI_CHAT_SKIN_BUBBLE = "Blizzard Chat Blasen verändern"
L_GUI_CHAT_CL_TAB = "Kampflog Reiter anzeigen"
L_GUI_CHAT_TABS_MOUSEOVER = "Zeige Chat-Reiter bei Mouseover"
L_GUI_CHAT_STICKY = "Behalte den letzen Channel"
L_GUI_CHAT_DAMAGE_METER_SPAM = "Fasse DMG-Meterspam in einer Zeile zusammen"

-- Nameplate options
L_GUI_NAMEPLATE_SUBTEXT = "Nameplates Einstellung"
L_GUI_NAMEPLATE_ENABLE = "Namensplaketten aktivieren"
L_GUI_NAMEPLATE_COMBAT = "Namensplaketten automatisch im Kampf anzeigen"
L_GUI_NAMEPLATE_HEALTH = "Numerischer Wert der Lebenspunkte"
L_GUI_NAMEPLATE_DISTANCE = "Anzeigerbereich"
L_GUI_NAMEPLATE_HEIGHT = "Höhe der Namensplakette"
L_GUI_NAMEPLATE_WIDTH = "Breite der Namensplakette"
L.nameplate_alpha = "Alpha" -- Needs review
L.nameplate_alpha_desc = "Non-target nameplate alpha" -- Needs review
L.nameplate_ad_height = "Zusätzliche Höhe"
L.nameplate_ad_width = "Zusätzliche Breite"
L.nameplate_ad_height_desc = "Additional height for selected nameplate" -- Needs review
L.nameplate_ad_width_desc = "Additional width for selected nameplate" -- Needs review
L_GUI_NAMEPLATE_CASTBAR_NAME = "Zeige den Namen in der Zauberleiste"
L_GUI_NAMEPLATE_CLASS_ICON = "Zeige Klassensymbole an (PvP)"
L_GUI_NAMEPLATE_NAME_ABBREV = "Namen abgekürzt anzeigen"
L_GUI_NAMEPLATE_CLAMP = "Clamp nameplates to the top of the screen when outside of view" -- Need review
L_GUI_NAMEPLATE_SHOW_DEBUFFS = "Zeige Schwächungszauber (Abgekürzte Namen müssen deaktiviert sein)"
L_GUI_NAMEPLATE_SHOW_BUFFS = "Show buffs above player nameplate (from the list)" -- Need review
L_GUI_NAMEPLATE_DEBUFFS_SIZE = "Größe der Debuffs"
L_GUI_NAMEPLATE_HEALER_ICON = "Zeige Heilersymbol auf allen gegnerischen Heiler-Nameplates im BG"
L_GUI_NAMEPLATE_TOTEM_ICONS = "Show icon above enemy totems nameplate" -- Need review
L_GUI_NAMEPLATE_THREAT = "Aktiviere Bedrohungsanzeige, ändert sich automatisch je nach deiner Rolle"
L_GUI_NAMEPLATE_GOOD_COLOR = "Positive Bedrohungsfarbe. Variiert abhängig ob Tank oder dps/heal"
L_GUI_NAMEPLATE_NEAR_COLOR = "Verlust oder Zuwachs der Bedrohung farbig kennzeichen"
L_GUI_NAMEPLATE_BAD_COLOR = "Negative Bedrohungsfarbe. Variiert abhängig ob Tank oder dps/heal"
L_GUI_NAMEPLATE_OFFTANK_COLOR = "Offtank threat color" -- Need review

-- Combat text options
L_GUI_COMBATTEXT = "Kampftext"
L_GUI_COMBATTEXT_SUBTEXT = "For moving type in the chat '/xct'" -- Need review
L_GUI_COMBATTEXT_ENABLE = "Kampftext aktivieren"
L.combattext_blizz_head_numbers = "Aktiviere Blizzard Kampftext"
L.combattext_blizz_head_numbers_desc = "Blizzard Schaden-/Heilausgabe benutzen (über Spieler/Kreaturen Kopf)"
L.combattext_damage_style = "Ändert die Standardkampfschriftart"
L.combattext_damage_style_desc = "Standard Schaden/Heilung Schriftart über Kreaturen/Spieler Köpfen ändern (Neustart von WoW erforderlich um Änderungen zu sehen)"
L_GUI_COMBATTEXT_DAMAGE = "Zeige ausgehenden Schaden in einem eigenen Fenster"
L_GUI_COMBATTEXT_HEALING = "Zeige ausgehende Heilung in einem eigenen Fenster"
L_GUI_COMBATTEXT_HOTS = "Zeige peroidische Heilungseffekte im Heilungsfenster"
L_GUI_COMBATTEXT_OVERHEALING = "Zeige ausgehende Überheilung an"
L_GUI_COMBATTEXT_PET_DAMAGE = "Zeige Begleiterschaden"
L_GUI_COMBATTEXT_DOT_DAMAGE = "Zeige Schaden von Schaden über Zeit"
L_GUI_COMBATTEXT_DAMAGE_COLOR = "Zeige Schadensnummern in Abhängigkeit von der Art des Zaubers"
L_GUI_COMBATTEXT_CRIT_PREFIX = "Symbol vor einem kritischen Treffer"
L_GUI_COMBATTEXT_CRIT_POSTFIX = "Symbol hinter einem kritischen Treffer"
L_GUI_COMBATTEXT_ICONS = "Zeige Symbole für ausgehenden Schaden"
L_GUI_COMBATTEXT_ICON_SIZE = "Icon größe"
L_GUI_COMBATTEXT_ICON_SIZE_DESC = "Symbolgröße der Zauber im Fenster für ausgehenden Schaden. Nimmt auch Einfluss auf die Schriftgröße"
L_GUI_COMBATTEXT_TRESHOLD = "Ab welcher Größe soll der Schaden angezeigt werden"
L_GUI_COMBATTEXT_HEAL_TRESHOLD = "Ab welche Größe soll ein-/ausgehende Heilung angezeigt werden"
L_GUI_COMBATTEXT_SCROLLABLE = "Erlaubt es dir mit dem Mausrad durch die letzten Zeilen zu scrollen"
L_GUI_COMBATTEXT_MAX_LINES = "Max. Zeilen"
L_GUI_COMBATTEXT_MAX_LINES_DESC = "Maximale Zeilen, die behalten werden sollen im Scrollmodus (mehr Zeilen = mehr Speicherverbrauch)"
L_GUI_COMBATTEXT_TIME_VISIBLE = "Zeit"
L_GUI_COMBATTEXT_TIME_VISIBLE_DESC = "Zeit(Sekunden) wielange eine einzelne Nachricht angezeigt wird"
L_GUI_COMBATTEXT_DK_RUNES = "Zeige Runenaufladung vom Todesritter"
L_GUI_COMBATTEXT_KILLINGBLOW = "Teilt dir mit ob du den Todesstoß bei einer Kreatur/einem Spieler hattest"
L_GUI_COMBATTEXT_MERGE_AOE_SPAM = "Vereint mehrfachen Flächenschaden in eine einzige Nachricht"
L_GUI_COMBATTEXT_MERGE_MELEE = "Fügt mehrfachen automatischen Angriffsschaden-Spam zusammen"
L_GUI_COMBATTEXT_DISPEL = "Informiert dich über deine Bannungen"
L_GUI_COMBATTEXT_INTERRUPT = "Informiert dich über deine Unterbrechungen"
L_GUI_COMBATTEXT_DIRECTION = "Ändert die Bildlaufrichtung von unten nach oben"
L_GUI_COMBATTEXT_SHORT_NUMBERS = "Zeige kurze Zahlen an ('25.3k' statt '25342')"

-- Auras/Buffs/Debuffs
L_GUI_AURA_PLAYER_BUFF_SIZE = "Buffs größe"
L_GUI_AURA_PLAYER_BUFF_SIZE_DESC = "Größe der Spielerbuffs"
L_GUI_AURA_SHOW_SPIRAL = "Spirale auf Buffsymbolen"
L_GUI_AURA_SHOW_TIMER = "Zeige Abklingzeit für Buffs"
L_GUI_AURA_PLAYER_AURAS = "Buffs auf dem Spielerfenster"
L_GUI_AURA_TARGET_AURAS = "Buffs auf dem Zielfenster"
L_GUI_AURA_FOCUS_DEBUFFS = "Debuffs auf dem Fokusfenster"
L_GUI_AURA_FOT_DEBUFFS = "Debuffs auf dem Fokusziel"
L_GUI_AURA_PET_DEBUFFS = "Debuffs auf dem Begleiterfenster"
L_GUI_AURA_TOT_DEBUFFS = "Debuffs bei Ziel des Ziels anzeigen"
L_GUI_AURA_BOSS_BUFFS = "Stärkungszauber auf dem Bossframe anzeigen."
L_GUI_AURA_PLAYER_AURA_ONLY = "Nur eigenen Debuffs bei dem Zielfenster anzeigen"
L_GUI_AURA_DEBUFF_COLOR_TYPE = "Debuffs nach Art einfärben"
L_GUI_AURA_CAST_BY = "Zeige im Tooltip an von wem ein Buff- bzw. Debuff gewirkt wurde"
L_GUI_AURA_CLASSCOLOR_BORDER = "Aktiviere Klassenfarbe für Spielerbuffs"

-- Bag options
L_GUI_BAGS = "Taschen"
L_GUI_BAGS_SUBTEXT = "Ändern der Blizzard Taschen."
L_GUI_BAGS_ENABLE = "Taschen aktivieren"
L_GUI_BAGS_ILVL = "Zeigt Itemlevel der Waffen & Rüstung"
L_GUI_BAGS_BUTTON_SIZE = "Buttongröße"
L_GUI_BAGS_BUTTON_SPACE = "Buttonabstand"
L_GUI_BAGS_BANK = "Anzahl der Spalten in der Bank"
L_GUI_BAGS_BAG = "Anzahl der Spalten in der Tasche"

-- Minimap options
L_GUI_MINIMAP_SUBTEXT = "Minimap Einstellungen."
L_GUI_MINIMAP_ENABLE = "Minimap aktivieren"
L_GUI_MINIMAP_ICON = "Aufspüren Symbol"
L_GUI_GARRISON_ICON = "Garrisons Symbol"
L_GUI_MINIMAP_SIZE = "Kartengröße"
L_GUI_MINIMAP_HIDE_COMBAT = "Minimap im Kampf verstecken"
L_GUI_MINIMAP_TOGGLE_MENU = "Zeige Toggle Menü"
L.minimap_bg_map_stylization = "Schlachtfeldkarte Aussehn"
L.minimap_fog_of_war = "Nebel des Krieges auf der Weltkarte"
L.minimap_fog_of_war_desc = "Right click on the close button of World Map to activate the option to hide fog of war" -- Need review

-- Loot options
L_GUI_LOOT_SUBTEXT = "Einstellungen für den Beuterahmen."
L_GUI_LOOT_ENABLE = "Plünderfenster aktivieren"
L_GUI_LOOT_ROLL_ENABLE = "Gruppenplünderfenster aktivieren"
L_GUI_LOOT_ICON_SIZE = "Symbolgröße"
L_GUI_LOOT_WIDTH = "Breite des Plünderfensters"
L_GUI_LOOT_AUTOGREED = "Aktiviere automatisches Würfeln (Gier) für Gegenstände, falls das höchste Level erreicht wurde."
L_GUI_LOOT_AUTODE = "Entzauberung automatisch bestätigen"
L.loot_faster_loot = "Schnelleres Plündern"
L.loot_faster_loot_desc = "Funktioniert nur, wenn die automatische Beute aktiviert ist"

-- Filger
L_GUI_FILGER = "Timers (Filger)"
L_GUI_FILGER_SUBTEXT = "Filger - analogue WeakAuras, but more simple and easy. Allows you to display in the form of icons and bars your auras and timers." -- Need review
L_GUI_FILGER_ENABLE = "Aktiviere Filger"
L_GUI_FILGER_TEST_MODE = "Test Icon Mode"
L_GUI_FILGER_MAX_TEST_ICON = "Anzahl der Icons im Test Mode"
L_GUI_FILGER_SHOW_TOOLTIP = "Zeige Tooltips"
L_GUI_FILGER_DISABLE_CD = "Deaktiviere Cooldowns"
L_GUI_FILGER_DISABLE_PVP = "Disable PvP debuffs on Player and Target" -- Need review
L_GUI_FILGER_EXPIRATION = "Sort cooldowns by expiration time" -- Need review
L_GUI_FILGER_BUFFS_SIZE = "Buffs größe ändern"
L_GUI_FILGER_COOLDOWN_SIZE = "Cooldowns größe ändern"
L_GUI_FILGER_PVP_SIZE = "PvP Debuffs größe ändern"

-- Announcements options
L_GUI_ANNOUNCEMENTS = "Benachrichtigungen"
L_GUI_ANNOUNCEMENTS_SUBTEXT = "Settings that add chat announcements about spells or items." -- Need review
L_GUI_ANNOUNCEMENTS_DRINKING = "Sage im Chat an wenn ein Arenagegener trinkt"
L_GUI_ANNOUNCEMENTS_INTERRUPTS = "Sage deine Unterbrechungen im Raid oder Schlachtzugschat an"
L_GUI_ANNOUNCEMENTS_SPELLS = "Sage im Raid/Schachtzugschat an, wenn du den selben Zauber castest"
L_GUI_ANNOUNCEMENTS_SPELLS_FROM_ALL = "Prüfe Zauber von allen Spielern"
L_GUI_ANNOUNCEMENTS_TOY_TRAIN = "Benachrichtigung über Spielzeugzug oder Düsterbräu's Fernbedienung"
L_GUI_ANNOUNCEMENTS_SAYS_THANKS = "Bedanke dich für einige Zauber"
L_GUI_ANNOUNCEMENTS_PULL_COUNTDOWN = "Pull cuntdown Benachrichtigung '/pc #'"
L_GUI_ANNOUNCEMENTS_FLASK_FOOD = "Benachrichtigung über Fläschchen und Bufffood (/ffcheck)"
L_GUI_ANNOUNCEMENTS_FLASK_FOOD_RAID = "Benachrichtigung in den Raid Channel"
L_GUI_ANNOUNCEMENTS_FLASK_FOOD_AUTO = "Automatische Benachrichtigung beim ReadyCheck"
L_GUI_ANNOUNCEMENTS_FEASTS = "Benachrichtigung wenn Festmahl/Kessel/Seelensteine/Reparatur Bots aufgestellt wurden"
L_GUI_ANNOUNCEMENTS_PORTALS = "Benachrichtigung über Portale/Ritual der Beschwörung"
L_GUI_ANNOUNCEMENTS_BAD_GEAR = "Überprüfe auf schlechte Ausrüstung in Instanzen"
L_GUI_ANNOUNCEMENTS_SAFARI_HAT = "Überprüfe Safari Hat"

-- Automation options
L_GUI_AUTOMATION = "Automatisierung"
L_GUI_AUTOMATION_SUBTEXT = "This block contains settings that facilitate the routine." -- Need review
L_GUI_AUTOMATION_DISMOUNT_STAND = "Auto dismount/stand" -- Needs review
L_GUI_AUTOMATION_RELEASE = "Automatisch im Schlachtfeld wiederbeleben"
L_GUI_AUTOMATION_SCREENSHOT = "Speicher einen Screenshot wenn ein Achivment errungen wird"
L.automation_solve_artifact = "Auto Popup für gelöste Artefakte"
L.automation_solve_artifact_desc = "If there are enough fragments for an artifact, a popup will appear to solve it." -- Need review
L_GUI_AUTOMATION_ACCEPT_INVITE = "Einladungen automatisch annehmen"
L_GUI_AUTOMATION_DECLINE_DUEL = "Duell automatisch ablehnen"
L_GUI_AUTOMATION_ACCEPT_QUEST = "Quests automatisch annehmen"
L_GUI_AUTOMATION_AUTO_COLLAPSE = "WatchFrame Automatisch in Instanzen reduzuieren"
L_GUI_AUTOMATION_AUTO_COLLAPSE_RELOAD = "Automatisches schließen der Questverfolgung nach Reload/RL"
L_GUI_AUTOMATION_SKIP_CINEMATIC = "Auto Cinematics/Filme überspringen"
L_GUI_AUTOMATION_AUTO_ROLE = "Automatisch die eigene Rolle wählen"
L_GUI_AUTOMATION_CANCEL_BAD_BUFFS = "Automatisch einige Buffs abbrechen"
L.automation_tab_binder = "Automatisch nur feindliche Spieler mit der TAB Taste anvisieren"
L.automation_tab_binder_desc = "'Tab' key target only enemy players when in PvP zones, ignores pets and mobs" -- Need review
L_GUI_AUTOMATION_LOGGING_COMBAT = "Automatisch Kampflog in Raids als Textdatei mitschreiben"
L.automation_buff_on_scroll = "Wirke Stärkungszauber mit Mausrad"
L.automation_buff_on_scroll_desc = "If the buff from the list is not applied to the player, it will cast by the mouse scroll" -- Need review
L_GUI_AUTOMATION_OPEN_ITEMS = "Öffnet Automatisch Items in der Tasche"
L.automation_invite_keyword = "Kurzes Schlüsselwort für Einladungen"
L.automation_invite_keyword_desc = "When player whisper you keyword he will be invited in your group. \nFor enable - type '/ainv'. Also after the command, you can write your word '/ainv inv'" -- Need review

-- Buffs reminder options
L_GUI_REMINDER = "Erinnerungen für Buffs"
L_GUI_REMINDER_SUBTEXT = "Anzeige der vermissten Auren."
L_GUI_REMINDER_SOLO_ENABLE = "Zeige fehlende Eigenbuffs"
L_GUI_REMINDER_SOLO_SOUND = "Spiele Warngeräusch ab bei fehlenden Eigenbuffs"
L_GUI_REMINDER_SOLO_SIZE = "Solo Icon größe"
L_GUI_REMINDER_SOLO_SIZE_DESC = "Eigener buff Icon größe"
L_GUI_REMINDER_SUBHEADER = "Raidbuffs"
L_GUI_REMINDER_RAID_ENABLE = "Zeige fehlende Raidbuffs an"
L_GUI_REMINDER_RAID_ALWAYS = "Zeige Bufferinnerungen immer an"
L_GUI_REMINDER_RAID_SIZE = "Raid Icon größe"
L_GUI_REMINDER_RAID_SIZE_DESC = "Symbolgröße für Raidbuffs"
L_GUI_REMINDER_RAID_ALPHA = "Transparent"
L_GUI_REMINDER_RAID_ALPHA_DESC = "Transparente Symbole wenn der Buff vorhanden ist"

-- Raid cooldowns options
L_GUI_COOLDOWN_RAID = "Schlachtzugs Cooldowns"
L_GUI_COOLDOWN_RAID_SUBTEXT = "Tracking raid abilities in the upper left corner." -- Need review
L_GUI_COOLDOWN_RAID_ENABLE = "Abklingzeiten des Raids aktivieren"
L_GUI_COOLDOWN_RAID_HEIGHT = "Bars height" -- Need review
L_GUI_COOLDOWN_RAID_WIDTH = "Bars width" -- Need review
L_GUI_COOLDOWN_RAID_SORT = "Leisten für Raidabklingzeiten wachsen nach oben"
L_GUI_COOLDOWN_RAID_EXPIRATION = "Sortieren nach Abklingzeit"
L_GUI_COOLDOWN_RAID_SHOW_SELF = "Zeige deine Cooldowns"
L_GUI_COOLDOWN_RAID_ICONS = "Symbole für Raidabklingzeiten"
L_GUI_COOLDOWN_RAID_IN_RAID = "Zeige Raidabklingzeiten in Raidgebieten"
L_GUI_COOLDOWN_RAID_IN_PARTY = "Zeige Raidabklingzeiten in Gruppengebieten"
L_GUI_COOLDOWN_RAID_IN_ARENA = "Zeige Raidabklingzeiten in der Arena"

-- Enemy cooldowns options
L_GUI_COOLDOWN_ENEMY = "Gegner Cooldowns"
L_GUI_COOLDOWN_ENEMY_SUBTEXT = "Tracking enemy abilities as icons above your spell casting bar." -- Need review
L_GUI_COOLDOWN_ENEMY_ENABLE = "Aktiviere gegnerische Abklingzeiten"
L_GUI_COOLDOWN_ENEMY_SIZE = "Symbolgröße für gegnerische Abklingzeiten"
L_GUI_COOLDOWN_ENEMY_DIRECTION = "Gegner Cooldowns Symbol ausrichtung"
L_GUI_COOLDOWN_ENEMY_EVERYWHERE = "Zeige gegnerische Abklingzeiten überall"
L_GUI_COOLDOWN_ENEMY_IN_BG = "Zeige gegnerische Abklingzeiten in Schlachtfeldern"
L_GUI_COOLDOWN_ENEMY_IN_ARENA = "Zeige gegnerische Abklingzeiten in der Arena"

-- Pulse cooldowns options
L_GUI_COOLDOWN_PULSE = "Pulse Cooldowns"
L_GUI_COOLDOWN_PULSE_SUBTEXT = "Track your cd using a pulse icon in the center of the screen." -- Need review
L_GUI_COOLDOWN_PULSE_ENABLE = "Zeige Abklingzeitimpuls"
L_GUI_COOLDOWN_PULSE_SIZE = "Abklingzeitimpuls Symbolgröße"
L_GUI_COOLDOWN_PULSE_SOUND = "Akustische Warnungen"
L_GUI_COOLDOWN_PULSE_ANIM_SCALE = "Animationen Skalieren"
L_GUI_COOLDOWN_PULSE_HOLD_TIME = "Maximale Zeit in der die Anzeige aktiv ist"
L_GUI_COOLDOWN_PULSE_THRESHOLD = "Threshold time" -- Need review
L_GUI_COOLDOWN_PULSE_THRESHOLD_DESC = "Minimale Zeitschwälle"

-- Threat options
L_GUI_THREAT = "Bedrohungsleisten"
L_GUI_THREAT_SUBTEXT = "Display of the threat list (a simple analogue of Omen)." -- Need review
L_GUI_THREAT_ENABLE = "Aktiviere Bedrohungsleisten"
L_GUI_THREAT_HEIGHT = "Höhe der Bedrohungsleisten"
L_GUI_THREAT_WIDTH = "Breite der Bedrohungsleisten"
L_GUI_THREAT_ROWS = "Anzahl der Bedrohungsleisten"
L_GUI_THREAT_HIDE_SOLO = "Nur in Gruppen oder Schlachtzügen anzeigen"

-- Top panel options
L_GUI_TOP_PANEL = "Oberes Panel"
L_GUI_TOP_PANEL_SUBTEXT = "Manage built-in top panel with information." -- Need review
L_GUI_TOP_PANEL_ENABLE = "Aktiviere oberes Panel"
L_GUI_TOP_PANEL_MOUSE = "Oberes Panel nur bei Mouseover anzeigen"
L_GUI_TOP_PANEL_WIDTH = "Breite des Panels"
L_GUI_TOP_PANEL_HEIGHT = "Höhe des Panels"

-- Stats options
L_GUI_STATS = "Statistiken"
L_GUI_STATS_SUBTEXT = "Statistik-Anzeige am unteren Bildschirmrand. Im Chat '/ls' für Info."
L_GUI_STATS_CLOCK = "Uhr"
L_GUI_STATS_LATENCY = "Latenz"
L_GUI_STATS_FPS = "BPS"
L_GUI_STATS_EXPERIENCE = "Erfahrung"
L_GUI_STATS_TALENTS_DESC = "Wechselt bei Klick die Beute und Spec"
L_GUI_STATS_COORDS = "Koordinaten"
L_GUI_STATS_LOCATION = "Ort"
L_GUI_STATS_BG = "Schlachtfeld"
L_GUI_STATS_SUBHEADER_CURRENCY = "Currency/Abzeichen (Anzeige im Gold Data Text)"
L_GUI_STATS_CURRENCY_ARCHAEOLOGY = "Zeige Archäologie Fragmente"
L_GUI_STATS_CURRENCY_COOKING = "Zeige Kochpreise/Marken"
L_GUI_STATS_CURRENCY_PROFESSIONS = "Zeige Berufeabzeichen/Tokens"
L_GUI_STATS_CURRENCY_RAID = "Zeige Schlatzugs Siegel/Bonuswürffe"

-- Error options
L_GUI_ERROR = "Fehler"
L_GUI_ERROR_SUBTEXT = "Filtern von Standardtext am oberen Bildschirmrand von Blizzard."
L_GUI_ERROR_BLACK = "Verstecke Fehler der Schwarzen Liste"
L_GUI_ERROR_WHITE = "Zeige Fehler der Weißen Liste"
L_GUI_ERROR_HIDE_COMBAT = "Verberge alle Fehlermeldungen im Kampf"

-- Miscellaneous options
L_GUI_MISC_SUBTEXT = "Andere Einstellungen, die interessante Funktionen hinzufügen."
L.misc_max_camera_distance = "Increase camera distance to max on login" -- Needs review
L.misc_shift_marking = "Marks mouseover target" -- Need review
L.misc_shift_marking_desc = "Marks mouseover target when you push Shift (only in group)" -- Need review
L_GUI_MISC_SPIN_CAMERA = "Kamera drehen während du AFK bist"
L_GUI_MISC_VEHICLE_MOUSEOVER = "Fahrzeugfenster bei mouseover anzeigen"
L_GUI_MISC_QUEST_AUTOBUTTON = "Quest/Gegenstand auto Taste"
L.misc_raid_tools = "Raid Hilfsmittel"
L.misc_raid_tools_desc = "Button at the top of the screen for ready check (Left-click), checking roles (Middle-click), setting marks, etc. (for leader and assistants)" -- Need review
L_GUI_MISC_PROFESSION_TABS = "Berufereiter an Handelsfähigkeiten und Handelsfenstern anzeigen"
L_GUI_MISC_HIDE_BG_SPAM = "In Schlachtfeldern Bossemotes im Chat unterbinden"
L.misc_hide_bg_spam_desc = "Entferne Boss Emote-Spam über den Gewinn/Verlust-Knoten während BG Arathi und Gilneas"
L_GUI_MISC_ITEM_LEVEL = "Itemlevel im Charakterfenster auf Items anzeigen"
L_GUI_MISC_ALREADY_KNOWN = "Bekannte Rezepte/Reittiere/Begleiter farblich hervorheben"
L_GUI_MISC_DISENCHANTING = "Sondieren, Mahlen and Entzaubern mit einem Klick"
L.misc_sum_buyouts = "Alle Auktionen aufsummieren"
L.misc_sum_buyouts_desc = "At auctions tab shows sum up all current auctions" -- Need review
L.misc_click_cast = "Simpler 'click2cast' spell binder"
L.misc_click_cast_desc = "Allows you to assign spells (analog Clique) to the mouse buttons. Setup through the side bookmark in the spell book" -- Need review
L.misc_click_cast_filter = "Ignoriere Spieler- und Zielfenster für click2cast"
L_GUI_MISC_MOVE_BLIZZARD = "Einige Blizzardfenster frei bewegbar machen"
L.misc_color_picker = "Verbesserte Farbauswahl"
L.misc_color_picker_desc = "Add copy/paste buttons and digit text entry for Blizzard color picker frame" -- Need review
L_GUI_MISC_ENCHANTMENT_SCROLL = "Verzauberung auf Rolle im Beruffenster"
L.misc_archaeology = "Archäologie Artifakte und Abklingzeit"
L.misc_archaeology_desc = "Archaeology tracker ('/arch' or right mouseover minimap button to show)" -- Need review
L.misc_chars_currency = "Zeige deine Währungstoken über diverse Karaktere"
L.misc_chars_currency_desc = "Hover over the icon of the required currency in the character window to display information in the tooltip" -- Need review
L.misc_armory_link = "Armory Link hinzufügen"
L.misc_armory_link_desc = "Add Armory Link im Spieler PopupMenus (Deaktiviert das Focusziel)"
L_GUI_MISC_MERCHANT_ITEMLEVEL = "Zeige Itemlevel für Waffen & Rüstung bei Händler"
L_GUI_MISC_MINIMIZE_MOUSEOVER = "Mouseover für Quest minimieren Taste"
L_GUI_MISC_HIDE_BANNER = "Autoverstecken des Boss Loot Frame"
L_GUI_MISC_HIDE_TALKING_HEAD = "Verstecke Talking Head Frame"
L.misc_hide_raid_button = "Verstecke oUF_RaidDPS Knopf"
L.misc_hide_raid_button_desc = "The button is displayed by hovering the mouse in the upper left corner" -- Need review
