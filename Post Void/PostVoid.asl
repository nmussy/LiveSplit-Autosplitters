state("Post Void") {
    double lvlID: 0x04B2780, 0x2C, 0x10, 0x18, 0x100;
    double igtFull: 0x04B2780, 0x2C, 0x10, 0x18, 0xE0;
    double igtLevel: 0x04B2780, 0x2C, 0x10, 0x18, 0xD0;
    //double kills: 0x04B2780, 0x2C, 0x10, 0x18, 0xC0;
    //double hits: 0x04B2780, 0x2C, 0x10, 0x18, 0xA0;
    //double shots: 0x04B2780, 0x2C, 0x10, 0x18, 0x90;
    //double headshots: 0x04B2780, 0x2C, 0x10, 0x18, 0x80;
    //double hitsTaken: 0x04B2780, 0x2C, 0x10, 0x18, 0x60;
}

startup {
    settings.Add("lvlSplits", true, "Choose which level(s) to split on:");
        settings.Add("0to1", true, "After Level 1", "lvlSplits");
        settings.Add("1to2", true, "After Level 2", "lvlSplits");
        settings.Add("2to3", true, "After Level 3", "lvlSplits");
        settings.Add("3to4", true, "After Level 4", "lvlSplits");
        settings.Add("4to5", true, "After Level 5", "lvlSplits");
        settings.Add("5to6", true, "After Level 6", "lvlSplits");
        settings.Add("6to7", true, "After Level 7", "lvlSplits");
        settings.Add("7to8", true, "After Level 8", "lvlSplits");
        settings.Add("8to9", true, "After Level 9", "lvlSplits");
        settings.Add("9to10", true, "After Level 10", "lvlSplits");
        settings.Add("finalSplit", true, "After Level 11", "lvlSplits");
}

init {
    vars.finalLevel = false;
}

start {
    if (old.igtFull == 0 && current.igtFull > 0) {
        vars.finalLevel = false;
        return true;
    }
}

split {
    if (current.lvlID == 10 && old.igtLevel == 0 && current.igtLevel > 0) vars.finalLevel = true;
    return
        old.lvlID < current.lvlID && settings[old.lvlID + "to" + current.lvlID] ||
        vars.finalLevel == true && old.igtLevel > 0 && current.igtLevel == 0 && settings["finalSplit"];
}

reset {
    return current.igtFull == 0 && old.igtFull > 0;
}

isLoading {
    return true;
}

gameTime {
    if (current.igtFull != 0) return TimeSpan.FromSeconds(current.igtFull);
}
