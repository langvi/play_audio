// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
    Data({
        this.id,
        this.joinedTime,
        this.startedEvent,
        this.favouriteTeam,
        this.playerFirstName,
        this.playerLastName,
        this.playerRegionId,
        this.playerRegionName,
        this.playerRegionIsoCodeShort,
        this.playerRegionIsoCodeLong,
        this.summaryOverallPoints,
        this.summaryOverallRank,
        this.summaryEventPoints,
        this.summaryEventRank,
        this.currentEvent,
        this.leagues,
        this.name,
        this.kit,
        this.lastDeadlineBank,
        this.lastDeadlineValue,
        this.lastDeadlineTotalTransfers,
    });

    int id;
    DateTime joinedTime;
    int startedEvent;
    int favouriteTeam;
    String playerFirstName;
    String playerLastName;
    int playerRegionId;
    String playerRegionName;
    String playerRegionIsoCodeShort;
    String playerRegionIsoCodeLong;
    int summaryOverallPoints;
    int summaryOverallRank;
    int summaryEventPoints;
    int summaryEventRank;
    int currentEvent;
    Leagues leagues;
    String name;
    String kit;
    int lastDeadlineBank;
    int lastDeadlineValue;
    int lastDeadlineTotalTransfers;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        joinedTime: DateTime.parse(json["joined_time"]),
        startedEvent: json["started_event"],
        favouriteTeam: json["favourite_team"],
        playerFirstName: json["player_first_name"],
        playerLastName: json["player_last_name"],
        playerRegionId: json["player_region_id"],
        playerRegionName: json["player_region_name"],
        playerRegionIsoCodeShort: json["player_region_iso_code_short"],
        playerRegionIsoCodeLong: json["player_region_iso_code_long"],
        summaryOverallPoints: json["summary_overall_points"],
        summaryOverallRank: json["summary_overall_rank"],
        summaryEventPoints: json["summary_event_points"],
        summaryEventRank: json["summary_event_rank"],
        currentEvent: json["current_event"],
        leagues: Leagues.fromJson(json["leagues"]),
        name: json["name"],
        kit: json["kit"],
        lastDeadlineBank: json["last_deadline_bank"],
        lastDeadlineValue: json["last_deadline_value"],
        lastDeadlineTotalTransfers: json["last_deadline_total_transfers"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "joined_time": joinedTime.toIso8601String(),
        "started_event": startedEvent,
        "favourite_team": favouriteTeam,
        "player_first_name": playerFirstName,
        "player_last_name": playerLastName,
        "player_region_id": playerRegionId,
        "player_region_name": playerRegionName,
        "player_region_iso_code_short": playerRegionIsoCodeShort,
        "player_region_iso_code_long": playerRegionIsoCodeLong,
        "summary_overall_points": summaryOverallPoints,
        "summary_overall_rank": summaryOverallRank,
        "summary_event_points": summaryEventPoints,
        "summary_event_rank": summaryEventRank,
        "current_event": currentEvent,
        "leagues": leagues.toJson(),
        "name": name,
        "kit": kit,
        "last_deadline_bank": lastDeadlineBank,
        "last_deadline_value": lastDeadlineValue,
        "last_deadline_total_transfers": lastDeadlineTotalTransfers,
    };
}

class Leagues {
    Leagues({
        this.classic,
        this.h2H,
        this.cup,
    });

    List<Classic> classic;
    List<dynamic> h2H;
    Cup cup;

    factory Leagues.fromJson(Map<String, dynamic> json) => Leagues(
        classic: List<Classic>.from(json["classic"].map((x) => Classic.fromJson(x))),
        h2H: List<dynamic>.from(json["h2h"].map((x) => x)),
        cup: Cup.fromJson(json["cup"]),
    );

    Map<String, dynamic> toJson() => {
        "classic": List<dynamic>.from(classic.map((x) => x.toJson())),
        "h2h": List<dynamic>.from(h2H.map((x) => x)),
        "cup": cup.toJson(),
    };
}

class Classic {
    Classic({
        this.id,
        this.name,
        this.shortName,
        this.created,
        this.closed,
        this.rank,
        this.maxEntries,
        this.leagueType,
        this.scoring,
        this.adminEntry,
        this.startEvent,
        this.entryCanLeave,
        this.entryCanAdmin,
        this.entryCanInvite,
        this.hasCup,
        this.cupLeague,
        this.cupQualified,
        this.entryRank,
        this.entryLastRank,
    });

    int id;
    String name;
    String shortName;
    DateTime created;
    bool closed;
    dynamic rank;
    dynamic maxEntries;
    String leagueType;
    String scoring;
    int adminEntry;
    int startEvent;
    bool entryCanLeave;
    bool entryCanAdmin;
    bool entryCanInvite;
    bool hasCup;
    int cupLeague;
    bool cupQualified;
    int entryRank;
    int entryLastRank;

    factory Classic.fromJson(Map<String, dynamic> json) => Classic(
        id: json["id"],
        name: json["name"],
        shortName: json["short_name"] == null ? null : json["short_name"],
        created: DateTime.parse(json["created"]),
        closed: json["closed"],
        rank: json["rank"],
        maxEntries: json["max_entries"],
        leagueType: json["league_type"],
        scoring: json["scoring"],
        adminEntry: json["admin_entry"] == null ? null : json["admin_entry"],
        startEvent: json["start_event"],
        entryCanLeave: json["entry_can_leave"],
        entryCanAdmin: json["entry_can_admin"],
        entryCanInvite: json["entry_can_invite"],
        hasCup: json["has_cup"],
        cupLeague: json["cup_league"] == null ? null : json["cup_league"],
        cupQualified: json["cup_qualified"] == null ? null : json["cup_qualified"],
        entryRank: json["entry_rank"],
        entryLastRank: json["entry_last_rank"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "short_name": shortName == null ? null : shortName,
        "created": created.toIso8601String(),
        "closed": closed,
        "rank": rank,
        "max_entries": maxEntries,
        "league_type": leagueType,
        "scoring": scoring,
        "admin_entry": adminEntry == null ? null : adminEntry,
        "start_event": startEvent,
        "entry_can_leave": entryCanLeave,
        "entry_can_admin": entryCanAdmin,
        "entry_can_invite": entryCanInvite,
        "has_cup": hasCup,
        "cup_league": cupLeague == null ? null : cupLeague,
        "cup_qualified": cupQualified == null ? null : cupQualified,
        "entry_rank": entryRank,
        "entry_last_rank": entryLastRank,
    };
}

class Cup {
    Cup({
        this.matches,
        this.status,
        this.cupLeague,
    });

    List<Match> matches;
    Status status;
    int cupLeague;

    factory Cup.fromJson(Map<String, dynamic> json) => Cup(
        matches: List<Match>.from(json["matches"].map((x) => Match.fromJson(x))),
        status: Status.fromJson(json["status"]),
        cupLeague: json["cup_league"],
    );

    Map<String, dynamic> toJson() => {
        "matches": List<dynamic>.from(matches.map((x) => x.toJson())),
        "status": status.toJson(),
        "cup_league": cupLeague,
    };
}

class Match {
    Match({
        this.id,
        this.entry1Entry,
        this.entry1Name,
        this.entry1PlayerName,
        this.entry1Points,
        this.entry1Win,
        this.entry1Draw,
        this.entry1Loss,
        this.entry1Total,
        this.entry2Entry,
        this.entry2Name,
        this.entry2PlayerName,
        this.entry2Points,
        this.entry2Win,
        this.entry2Draw,
        this.entry2Loss,
        this.entry2Total,
        this.isKnockout,
        this.winner,
        this.seedValue,
        this.event,
        this.tiebreak,
    });

    int id;
    int entry1Entry;
    String entry1Name;
    String entry1PlayerName;
    int entry1Points;
    int entry1Win;
    int entry1Draw;
    int entry1Loss;
    int entry1Total;
    int entry2Entry;
    String entry2Name;
    String entry2PlayerName;
    int entry2Points;
    int entry2Win;
    int entry2Draw;
    int entry2Loss;
    int entry2Total;
    bool isKnockout;
    int winner;
    dynamic seedValue;
    int event;
    dynamic tiebreak;

    factory Match.fromJson(Map<String, dynamic> json) => Match(
        id: json["id"],
        entry1Entry: json["entry_1_entry"],
        entry1Name: json["entry_1_name"],
        entry1PlayerName: json["entry_1_player_name"],
        entry1Points: json["entry_1_points"],
        entry1Win: json["entry_1_win"],
        entry1Draw: json["entry_1_draw"],
        entry1Loss: json["entry_1_loss"],
        entry1Total: json["entry_1_total"],
        entry2Entry: json["entry_2_entry"],
        entry2Name: json["entry_2_name"],
        entry2PlayerName: json["entry_2_player_name"],
        entry2Points: json["entry_2_points"],
        entry2Win: json["entry_2_win"],
        entry2Draw: json["entry_2_draw"],
        entry2Loss: json["entry_2_loss"],
        entry2Total: json["entry_2_total"],
        isKnockout: json["is_knockout"],
        winner: json["winner"],
        seedValue: json["seed_value"],
        event: json["event"],
        tiebreak: json["tiebreak"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "entry_1_entry": entry1Entry,
        "entry_1_name": entry1Name,
        "entry_1_player_name": entry1PlayerName,
        "entry_1_points": entry1Points,
        "entry_1_win": entry1Win,
        "entry_1_draw": entry1Draw,
        "entry_1_loss": entry1Loss,
        "entry_1_total": entry1Total,
        "entry_2_entry": entry2Entry,
        "entry_2_name": entry2Name,
        "entry_2_player_name": entry2PlayerName,
        "entry_2_points": entry2Points,
        "entry_2_win": entry2Win,
        "entry_2_draw": entry2Draw,
        "entry_2_loss": entry2Loss,
        "entry_2_total": entry2Total,
        "is_knockout": isKnockout,
        "winner": winner,
        "seed_value": seedValue,
        "event": event,
        "tiebreak": tiebreak,
    };
}

class Status {
    Status({
        this.qualificationEvent,
        this.qualificationNumbers,
        this.qualificationRank,
        this.qualificationState,
    });

    int qualificationEvent;
    int qualificationNumbers;
    int qualificationRank;
    String qualificationState;

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        qualificationEvent: json["qualification_event"],
        qualificationNumbers: json["qualification_numbers"],
        qualificationRank: json["qualification_rank"],
        qualificationState: json["qualification_state"],
    );

    Map<String, dynamic> toJson() => {
        "qualification_event": qualificationEvent,
        "qualification_numbers": qualificationNumbers,
        "qualification_rank": qualificationRank,
        "qualification_state": qualificationState,
    };
}
