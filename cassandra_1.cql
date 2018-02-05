drop table if exists bikeup.strava_detailed_activities;
drop type if exists bikeup.segment_effort;
drop type if exists bikeup.lap;
drop type if exists bikeup.splits_standard;
drop type if exists bikeup.splits_metric;
drop type if exists bikeup.achievements;
drop type if exists bikeup.segment;
drop type if exists bikeup.photos;
drop type if exists bikeup.activity_map;
drop type if exists bikeup.activity;
drop type if exists bikeup.athlete;
drop type if exists bikeup.gear;
drop type if exists bikeup.kudoser;

create type bikeup.kudoser(
  avatar_url text,
  destination_url text,
  display_name text,
  show_name boolean
);

create type bikeup.gear(
  distance float,
  id text,
  name text,
  "primary" boolean,
  resource_state int
);

create type bikeup.athlete(
  id bigint,
  resource_state int
);

create type bikeup.activity(
  id bigint,
  resource_state int
);

create type bikeup.activity_map(
  id text,
  resource_state int,
  summary_polyline text,
  polyline text
);

create type bikeup.photos(
  count int,
  "primary" text
);

create type bikeup.achievements(
  type_id bigint,
  type text,
  rank int
);

create type bikeup.segment(
  activity_type text,
  average_grade float,
  city text,
  climb_category int,
  country text,
  distance float,
  elevation_high float,
  elevation_low float,
  end_latitude double,
  end_latlng list<double>,
  end_longitude double,
  hazardous boolean,
  id bigint,
  maximum_grade float,
  name text,
  private boolean,
  resource_state int,
  starred boolean,
  start_latitude double,
  start_latlng list<double>,
  start_longitude double,
  state text
);

create type bikeup.segment_effort(
  achievements list<frozen<achievements>>,
  activity frozen<activity>,
  athlete frozen<athlete>,
  average_cadence float,
  average_heartrate float,
  max_heartrate float,
  average_watts float,
  device_watts boolean,
  distance float,
  elapsed_time int,
  end_index int,
  hidden boolean,
  id bigint,
  kom_rank int,
  moving_time int,
  name text,
  pr_rank int,
  resource_state int,
  segment frozen<segment>,
  start_date timestamp,
  start_date_local timestamp,
  start_index int
);

create type bikeup.splits_metric(
  average_speed float,
  average_heartrate float,
  distance float,
  elapsed_time int,
  elevation_difference float,
  moving_time int,
  pace_zone int,
  split int
);

create type bikeup.splits_standard(
  average_speed float,
  average_heartrate float,
  distance float,
  elapsed_time int,
  elevation_difference float,
  moving_time int,
  pace_zone int,
  split int
);

create type bikeup.lap(
  activity frozen<activity>,
  athlete frozen<athlete>,
  average_watts float,
  average_heartrate float,
  max_heartrate float,
  device_watts boolean,
  average_cadence float,
  average_speed float,
  distance float,
  elapsed_time int,
  end_index int,
  id bigint,
  lap_index int,
  max_speed float,
  moving_time int,
  name text,
  resource_state int,
  split int,
  start_date timestamp,
  start_date_local timestamp,
  start_index int,
  total_elevation_gain float
);

create table bikeup.strava_detailed_activities(
    achievement_count int,
    athlete frozen<athlete>,
    athlete_count int,
    average_cadence float,
    average_heartrate float,
    average_speed float,
    average_watts float,
    calories float,
    comment_count int,
    commute boolean,
    description text,
    device_name text,
    device_watts boolean,
    distance float,
    elapsed_time int,
    elev_high float,
    elev_low float,
    embed_token text,
    end_latlng list<double>,
    external_id text,
    flagged boolean,
    from_accepted_tag boolean,
    gear frozen<gear>,
    gear_id text,
    has_heartrate boolean,
    has_kudoed boolean,
    highlighted_kudosers list<frozen<kudoser>>,
    id bigint primary key,
    kilojoules float,
    kudos_count int,
    laps list<frozen <lap>>,
    location_city varchar,
    location_country varchar,
    location_state varchar,
    manual boolean,
    "map" frozen<activity_map>,
    max_speed float,
    max_heartrate float,
    moving_time int,
    name text,
    partner_brand_tag text,
    photo_count int,
    photos frozen<photos>,
    pr_count int,
    private boolean,
    resource_state int,
    segment_efforts list<frozen <segment_effort>>,
    segment_leaderboard_opt_out boolean,
    splits_metric list<frozen <splits_metric>>,
    splits_standard list<frozen <splits_standard>>,
    start_date timestamp,
    start_date_local timestamp,
    start_latitude double,
    start_latlng list<double>,
    start_longitude double,
    timezone text,
    total_elevation_gain float,
    total_photo_count int,
    trainer boolean,
    type text,
    upload_id bigint,
    utc_offset float,
    workout_type int
);
