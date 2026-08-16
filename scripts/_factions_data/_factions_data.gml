enum factions {
    federation,
    pirates,
    merchants,
    republic,
    nomads,
    syndicate
}

global.faction_data = [];

global.faction_data[factions.federation] = {
    name: "Federation",
    transponder: {
        color: c_aqua,
        text: c_white,
    }
};

global.faction_data[factions.pirates] = {
    name: "Pirates",
    transponder: {
        color: c_red,
        text: c_orange,
    }
};

global.faction_data[factions.merchants] = {
    name: "Merchants"
};

global.faction_data[factions.republic] = {
    name: "Republic"
};

global.faction_data[factions.nomads] = {
    name: "Nomads"
};

global.faction_data[factions.syndicate] = {
    name: "Syndicate"
};