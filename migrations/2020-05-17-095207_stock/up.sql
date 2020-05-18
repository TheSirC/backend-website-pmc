--
-- PostgreSQL database dump
--

-- Dumped from database version 11.7
-- Dumped by pg_dump version 11.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: sirc
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO sirc;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: sirc
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: positive_float; Type: DOMAIN; Schema: public; Owner: sirc
--

CREATE DOMAIN public.positive_float AS double precision
	CONSTRAINT positive_float_check CHECK ((VALUE > (0)::double precision));


ALTER DOMAIN public.positive_float OWNER TO sirc;

--
-- Name: positive_float_range; Type: TYPE; Schema: public; Owner: sirc
--

CREATE TYPE public.positive_float_range AS RANGE (
    subtype = public.positive_float
);


ALTER TYPE public.positive_float_range OWNER TO sirc;

--
-- Name: diesel_manage_updated_at(regclass); Type: FUNCTION; Schema: public; Owner: sirc
--

CREATE FUNCTION public.diesel_manage_updated_at(_tbl regclass) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    EXECUTE format('CREATE TRIGGER set_updated_at BEFORE UPDATE ON %s
                    FOR EACH ROW EXECUTE PROCEDURE diesel_set_updated_at()', _tbl);
END;
$$;


ALTER FUNCTION public.diesel_manage_updated_at(_tbl regclass) OWNER TO sirc;

--
-- Name: diesel_set_updated_at(); Type: FUNCTION; Schema: public; Owner: sirc
--

CREATE FUNCTION public.diesel_set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (
        NEW IS DISTINCT FROM OLD AND
        NEW.updated_at IS NOT DISTINCT FROM OLD.updated_at
    ) THEN
        NEW.updated_at := current_timestamp;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.diesel_set_updated_at() OWNER TO sirc;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: __diesel_schema_migrations; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.__diesel_schema_migrations (
    version character varying(50) NOT NULL,
    run_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.__diesel_schema_migrations OWNER TO sirc;

--
-- Name: beamsplitters; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.beamsplitters (
    manufacturer text,
    model text DEFAULT 'Unknown'::text,
    diameter public.positive_float,
    quantity integer DEFAULT 1,
    shape text DEFAULT 'round'::text,
    mounted boolean DEFAULT false,
    polarising boolean DEFAULT false,
    localisation integer NOT NULL,
    operatingwavelengthrange public.positive_float_range,
    model_type text,
    arrange public.positive_float_range,
    reflectance integer DEFAULT 50,
    transmittance integer DEFAULT 50,
    thickness public.positive_float,
    id integer NOT NULL,
    CONSTRAINT beamsplitters_quantity_check CHECK ((quantity > 0)),
    CONSTRAINT beamsplitters_reflectance_check CHECK ((reflectance > 0)),
    CONSTRAINT beamsplitters_transmittance_check CHECK ((transmittance > 0))
);


ALTER TABLE public.beamsplitters OWNER TO sirc;

--
-- Name: beamsplitters_id_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.beamsplitters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.beamsplitters_id_seq OWNER TO sirc;

--
-- Name: beamsplitters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.beamsplitters_id_seq OWNED BY public.beamsplitters.id;


--
-- Name: beamsplitters_localisation_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.beamsplitters_localisation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.beamsplitters_localisation_seq OWNER TO sirc;

--
-- Name: beamsplitters_localisation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.beamsplitters_localisation_seq OWNED BY public.beamsplitters.localisation;


--
-- Name: beamsplittertype; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.beamsplittertype (
    name text NOT NULL
);


ALTER TABLE public.beamsplittertype OWNER TO sirc;

--
-- Name: filters; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.filters (
    manufacturer text,
    model text,
    diameter public.positive_float DEFAULT 25.4,
    quantity integer DEFAULT 1 NOT NULL,
    shape text DEFAULT 'round'::text,
    mounted boolean DEFAULT false,
    localisation integer DEFAULT 1 NOT NULL,
    operatingwavelengthrange public.positive_float_range,
    adjustable boolean DEFAULT false,
    id integer NOT NULL,
    CONSTRAINT filters_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.filters OWNER TO sirc;

--
-- Name: COLUMN filters.manufacturer; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.filters.manufacturer IS 'The manufacturer of the filter';


--
-- Name: COLUMN filters.model; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.filters.model IS 'Model name or number given by the manufacturer';


--
-- Name: COLUMN filters.diameter; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.filters.diameter IS 'Diameter of the clear aperture of the lens in millimeters (25.4 by default)';


--
-- Name: COLUMN filters.quantity; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.filters.quantity IS 'Number of this model at the location (1 by default)';


--
-- Name: COLUMN filters.shape; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.filters.shape IS 'Physical shape of the filter (Round by default)';


--
-- Name: COLUMN filters.mounted; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.filters.mounted IS 'If the filter comes mounted or not (false by default)';


--
-- Name: COLUMN filters.operatingwavelengthrange; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.filters.operatingwavelengthrange IS 'Range of wavelengths, in nanometers, the filter can transmit with 50% transmittance or more';


--
-- Name: filters_id_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.filters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.filters_id_seq OWNER TO sirc;

--
-- Name: filters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.filters_id_seq OWNED BY public.filters.id;


--
-- Name: filters_localisation_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.filters_localisation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.filters_localisation_seq OWNER TO sirc;

--
-- Name: filters_localisation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.filters_localisation_seq OWNED BY public.filters.localisation;


--
-- Name: lasers; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.lasers (
    manufacturer text,
    model text,
    quantity integer DEFAULT 1,
    shape text,
    mounted boolean,
    localisation integer DEFAULT 1 NOT NULL,
    maxpower public.positive_float,
    voltage public.positive_float,
    wavelength public.positive_float,
    id integer NOT NULL,
    CONSTRAINT lasers_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.lasers OWNER TO sirc;

--
-- Name: COLUMN lasers.maxpower; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.lasers.maxpower IS 'The maximum output power in the nominal range of the laser (in mW)';


--
-- Name: COLUMN lasers.voltage; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.lasers.voltage IS 'The voltage that should be used to power the laser (in V)';


--
-- Name: COLUMN lasers.wavelength; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.lasers.wavelength IS 'The operating wavelength of the laser (in nm)';


--
-- Name: lasers_id_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.lasers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lasers_id_seq OWNER TO sirc;

--
-- Name: lasers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.lasers_id_seq OWNED BY public.lasers.id;


--
-- Name: lasers_localisation_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.lasers_localisation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lasers_localisation_seq OWNER TO sirc;

--
-- Name: lasers_localisation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.lasers_localisation_seq OWNED BY public.lasers.localisation;


--
-- Name: leds; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.leds (
    manufacturer text,
    model text,
    diameter public.positive_float,
    quantity integer,
    shape text,
    mounted boolean,
    localisation integer NOT NULL,
    operatingwavelengthrange public.positive_float_range,
    color text,
    operatingvoltage public.positive_float,
    operatingcurrent public.positive_float,
    maxpower real,
    id integer NOT NULL,
    CONSTRAINT leds_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.leds OWNER TO sirc;

--
-- Name: leds_id_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.leds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.leds_id_seq OWNER TO sirc;

--
-- Name: leds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.leds_id_seq OWNED BY public.leds.id;


--
-- Name: leds_localisation_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.leds_localisation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.leds_localisation_seq OWNER TO sirc;

--
-- Name: leds_localisation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.leds_localisation_seq OWNED BY public.leds.localisation;


--
-- Name: lenses; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.lenses (
    manufacturer text,
    model text DEFAULT 'Unknown'::text,
    diameter public.positive_float DEFAULT 25.4,
    quantity integer DEFAULT 1,
    shape text DEFAULT 'round'::text,
    mounted boolean DEFAULT false,
    mount_type text,
    localisation integer NOT NULL,
    operatingwavelengthrange public.positive_float_range DEFAULT '[400,800]'::public.positive_float_range,
    model_type text DEFAULT 'unmounted'::text,
    arrange public.positive_float_range DEFAULT '[400,800]'::public.positive_float_range,
    focal_length real,
    id integer NOT NULL,
    CONSTRAINT lenses_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.lenses OWNER TO sirc;

--
-- Name: COLUMN lenses.manufacturer; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.lenses.manufacturer IS 'Manufacturer of the lense';


--
-- Name: COLUMN lenses.model; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.lenses.model IS 'Model name or number given by the manufacturer (Unknown by default)';


--
-- Name: COLUMN lenses.diameter; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.lenses.diameter IS 'Diameter of the clear aperture of the lens in millimeters (25.4 by default)';


--
-- Name: COLUMN lenses.quantity; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.lenses.quantity IS 'Number of this model at the location (1 by default)';


--
-- Name: COLUMN lenses.shape; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.lenses.shape IS 'Physical shape of the lens (Round by default)';


--
-- Name: COLUMN lenses.mounted; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.lenses.mounted IS 'If the lens comes mounted or not (false by default)';


--
-- Name: COLUMN lenses.mount_type; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.lenses.mount_type IS 'The name of the mount if the lens is mounted';


--
-- Name: COLUMN lenses.operatingwavelengthrange; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.lenses.operatingwavelengthrange IS 'Range of wavelengths, in nanometers, the lens can transmit (400-800 nm by default)';


--
-- Name: COLUMN lenses.model_type; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.lenses.model_type IS 'The type of the lens (unmounted by default)';


--
-- Name: COLUMN lenses.arrange; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.lenses.arrange IS 'Range of the antireflection coating of the lense (400-800 nm by default)';


--
-- Name: COLUMN lenses.focal_length; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.lenses.focal_length IS 'Focal length of the lense';


--
-- Name: lenses_id_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.lenses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lenses_id_seq OWNER TO sirc;

--
-- Name: lenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.lenses_id_seq OWNED BY public.lenses.id;


--
-- Name: lenses_localisation_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.lenses_localisation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lenses_localisation_seq OWNER TO sirc;

--
-- Name: lenses_localisation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.lenses_localisation_seq OWNED BY public.lenses.localisation;


--
-- Name: lensmount; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.lensmount (
    name text NOT NULL
);


ALTER TABLE public.lensmount OWNER TO sirc;

--
-- Name: lenstype; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.lenstype (
    name text NOT NULL
);


ALTER TABLE public.lenstype OWNER TO sirc;

--
-- Name: localisations; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.localisations (
    id integer NOT NULL,
    localisation text,
    experimenter text
);


ALTER TABLE public.localisations OWNER TO sirc;

--
-- Name: localisations_id_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.localisations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.localisations_id_seq OWNER TO sirc;

--
-- Name: localisations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.localisations_id_seq OWNED BY public.localisations.id;


--
-- Name: manufacturers; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.manufacturers (
    name text NOT NULL
);


ALTER TABLE public.manufacturers OWNER TO sirc;

--
-- Name: mirrors; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.mirrors (
    manufacturer text,
    model text,
    diameter public.positive_float DEFAULT 25.4,
    quantity integer DEFAULT 1,
    shape text DEFAULT 'round'::text,
    mounted boolean DEFAULT false,
    localisation integer DEFAULT 1 NOT NULL,
    operatingwavelengthrange public.positive_float_range,
    id integer NOT NULL,
    CONSTRAINT mirrors_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.mirrors OWNER TO sirc;

--
-- Name: COLUMN mirrors.manufacturer; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.mirrors.manufacturer IS 'The manufacturer of the mirror';


--
-- Name: COLUMN mirrors.model; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.mirrors.model IS 'Model name or number given by the manufacturer';


--
-- Name: COLUMN mirrors.diameter; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.mirrors.diameter IS 'Diameter of the reflective part of the mirror in millimeters (25.4 by default)';


--
-- Name: COLUMN mirrors.quantity; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.mirrors.quantity IS 'Number of this model at the location (1 by default)';


--
-- Name: COLUMN mirrors.shape; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.mirrors.shape IS 'Physical shape of the mirror (Round by default)';


--
-- Name: COLUMN mirrors.mounted; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.mirrors.mounted IS 'If the mirror comes mounted or not (false by default)';


--
-- Name: COLUMN mirrors.operatingwavelengthrange; Type: COMMENT; Schema: public; Owner: sirc
--

COMMENT ON COLUMN public.mirrors.operatingwavelengthrange IS 'Range of wavelengths, in nanometers, the mirror can reflect with 90% reflectance or more';


--
-- Name: mirrors_id_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.mirrors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mirrors_id_seq OWNER TO sirc;

--
-- Name: mirrors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.mirrors_id_seq OWNED BY public.mirrors.id;


--
-- Name: mirrors_localisation_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.mirrors_localisation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mirrors_localisation_seq OWNER TO sirc;

--
-- Name: mirrors_localisation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.mirrors_localisation_seq OWNED BY public.mirrors.localisation;


--
-- Name: polarizers; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.polarizers (
    manufacturer text,
    model text,
    diameter public.positive_float,
    quantity integer,
    shape text,
    mounted boolean,
    localisation integer,
    operatingwavelengthrange public.positive_float_range,
    model_type text,
    id integer NOT NULL,
    CONSTRAINT polarizer_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.polarizers OWNER TO sirc;

--
-- Name: polarizer_localisation_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.polarizer_localisation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.polarizer_localisation_seq OWNER TO sirc;

--
-- Name: polarizer_localisation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.polarizer_localisation_seq OWNED BY public.polarizers.localisation;


--
-- Name: polarizers_id_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.polarizers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.polarizers_id_seq OWNER TO sirc;

--
-- Name: polarizers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.polarizers_id_seq OWNED BY public.polarizers.id;


--
-- Name: polarizertype; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.polarizertype (
    name text NOT NULL
);


ALTER TABLE public.polarizertype OWNER TO sirc;

--
-- Name: shapes; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.shapes (
    name text NOT NULL
);


ALTER TABLE public.shapes OWNER TO sirc;

--
-- Name: waveplates; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.waveplates (
    manufacturer text,
    model text,
    diameter public.positive_float,
    quantity integer,
    shape text,
    mounted boolean,
    localisation integer NOT NULL,
    operatingwavelengthrange public.positive_float_range,
    model_type text,
    arrange public.positive_float_range,
    id integer NOT NULL,
    CONSTRAINT waveplates_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.waveplates OWNER TO sirc;

--
-- Name: waveplates_id_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.waveplates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.waveplates_id_seq OWNER TO sirc;

--
-- Name: waveplates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.waveplates_id_seq OWNED BY public.waveplates.id;


--
-- Name: waveplates_localisation_seq; Type: SEQUENCE; Schema: public; Owner: sirc
--

CREATE SEQUENCE public.waveplates_localisation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.waveplates_localisation_seq OWNER TO sirc;

--
-- Name: waveplates_localisation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sirc
--

ALTER SEQUENCE public.waveplates_localisation_seq OWNED BY public.waveplates.localisation;


--
-- Name: waveplatetype; Type: TABLE; Schema: public; Owner: sirc
--

CREATE TABLE public.waveplatetype (
    name text NOT NULL
);


ALTER TABLE public.waveplatetype OWNER TO sirc;

--
-- Name: beamsplitters localisation; Type: DEFAULT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.beamsplitters ALTER COLUMN localisation SET DEFAULT nextval('public.beamsplitters_localisation_seq'::regclass);


--
-- Name: beamsplitters id; Type: DEFAULT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.beamsplitters ALTER COLUMN id SET DEFAULT nextval('public.beamsplitters_id_seq'::regclass);


--
-- Name: filters id; Type: DEFAULT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.filters ALTER COLUMN id SET DEFAULT nextval('public.filters_id_seq'::regclass);


--
-- Name: lasers id; Type: DEFAULT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.lasers ALTER COLUMN id SET DEFAULT nextval('public.lasers_id_seq'::regclass);


--
-- Name: leds localisation; Type: DEFAULT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.leds ALTER COLUMN localisation SET DEFAULT nextval('public.leds_localisation_seq'::regclass);


--
-- Name: leds id; Type: DEFAULT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.leds ALTER COLUMN id SET DEFAULT nextval('public.leds_id_seq'::regclass);


--
-- Name: lenses localisation; Type: DEFAULT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.lenses ALTER COLUMN localisation SET DEFAULT nextval('public.lenses_localisation_seq'::regclass);


--
-- Name: lenses id; Type: DEFAULT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.lenses ALTER COLUMN id SET DEFAULT nextval('public.lenses_id_seq'::regclass);


--
-- Name: localisations id; Type: DEFAULT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.localisations ALTER COLUMN id SET DEFAULT nextval('public.localisations_id_seq'::regclass);


--
-- Name: mirrors id; Type: DEFAULT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.mirrors ALTER COLUMN id SET DEFAULT nextval('public.mirrors_id_seq'::regclass);


--
-- Name: polarizers id; Type: DEFAULT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.polarizers ALTER COLUMN id SET DEFAULT nextval('public.polarizers_id_seq'::regclass);


--
-- Name: waveplates id; Type: DEFAULT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.waveplates ALTER COLUMN id SET DEFAULT nextval('public.waveplates_id_seq'::regclass);


--
-- Data for Name: __diesel_schema_migrations; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.__diesel_schema_migrations VALUES ('00000000000000', '2020-05-16 21:39:31.404023');


--
-- Data for Name: beamsplitters; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.beamsplitters VALUES ('Thorlabs', 'BSW29R', 25, 1, 'rectangular', false, false, 1, '[600,1700]', 'plate', '[600,1700]', 50, 50, 1, 1);
INSERT INTO public.beamsplitters VALUES (NULL, '', 20, 1, 'cubic', false, false, 1, NULL, NULL, '[400,800]', NULL, NULL, 1, 2);
INSERT INTO public.beamsplitters VALUES ('J. Fichou', '', 20, 1, 'cubic', false, false, 1, '[780,780]', NULL, NULL, NULL, NULL, 20, 3);
INSERT INTO public.beamsplitters VALUES ('J. Fichou', '03BTF007', 50, 1, 'square', false, false, 1, '[600,1700]', NULL, NULL, 50, 50, NULL, 4);
INSERT INTO public.beamsplitters VALUES ('Thorlabs', 'CCM1-BS013/M', 30, 1, 'cubic', false, false, 1, NULL, NULL, '[400,700]', 50, 50, 30, 5);
INSERT INTO public.beamsplitters VALUES ('Coherent', '44-3887-0000', 20, 1, 'cubic', false, false, 1, NULL, NULL, '[1200,1600]', 45, 45, 20, 6);
INSERT INTO public.beamsplitters VALUES ('Thorlabs', 'BS028', 25.3999999999999986, 1, 'cubic', false, false, 1, NULL, NULL, '[400,700]', 90, 10, 25.3999999999999986, 7);
INSERT INTO public.beamsplitters VALUES ('Thorlabs', 'CM1-BS013', 30, 1, 'cubic', false, false, 1, NULL, NULL, '[400,700]', 50, 50, 30, 8);
INSERT INTO public.beamsplitters VALUES ('Thorlabs', 'BS020', 25.3999999999999986, 2, 'cubic', false, false, 1, NULL, NULL, '[700,1100]', 30, 70, 25.3999999999999986, 9);
INSERT INTO public.beamsplitters VALUES ('Thorlabs', 'BS029', 25.3999999999999986, 1, 'cubic', false, false, 1, NULL, NULL, '[700,1100]', 90, 10, 25.3999999999999986, 10);
INSERT INTO public.beamsplitters VALUES ('Thorlabs', 'CCM1-PBS252/M', 30, 1, 'cubic', false, true, 1, NULL, NULL, NULL, 50, 50, 30, 11);
INSERT INTO public.beamsplitters VALUES ('Thorlabs', 'BSW29R', 25, 1, 'rectangular', false, false, 6, NULL, NULL, '[600,1700]', 50, 50, 1, 12);


--
-- Data for Name: beamsplittertype; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.beamsplittertype VALUES ('pellicle');
INSERT INTO public.beamsplittertype VALUES ('plate');
INSERT INTO public.beamsplittertype VALUES ('dichroic');


--
-- Data for Name: filters; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.filters VALUES ('Semrock', 'FF757-Di01-25x36', 36, 1, 'rectangular', false, 1, '[757,1100]', false, 1);
INSERT INTO public.filters VALUES ('Semrock', 'FF01-780/12-25', 36, 1, 'rectangular', false, 1, '[770,790]', false, 2);
INSERT INTO public.filters VALUES ('Edmund Optics', '65678', 25.3999999999999986, 1, 'round', false, 7, '[395,415]', false, 3);
INSERT INTO public.filters VALUES ('Melles Griot', '03 FIU 131', 25.3999999999999986, 1, 'round', false, 1, NULL, false, 4);
INSERT INTO public.filters VALUES ('Thorlabs', 'FB590-10', 25.3999999999999986, 1, 'round', false, 7, '[580,600)', false, 5);
INSERT INTO public.filters VALUES ('Thorlabs', 'FEL0600', 25.3999999999999986, 1, 'round', false, 2, '[600,Infinity]', false, 6);
INSERT INTO public.filters VALUES ('Thorlabs', 'FB440-10', 25.3999999999999986, 1, 'round', false, 7, '[430,450]', false, 7);
INSERT INTO public.filters VALUES ('Edmund Optics', '67835', 50, 1, 'round', false, 7, '[567,587)', false, 8);
INSERT INTO public.filters VALUES ('Edmund Optics', '65688', 25.3999999999999986, 1, 'round', false, 7, '[457,477]', false, 9);
INSERT INTO public.filters VALUES ('Edmund Optics', '65690', 25.3999999999999986, 1, 'round', false, 7, '[470,490]', false, 10);
INSERT INTO public.filters VALUES ('Schott', '72077.22', 50, 1, 'round', false, 1, '[446,552]', false, 11);
INSERT INTO public.filters VALUES ('Edmund Optics', '65696', 25.3999999999999986, 1, 'round', false, 7, '[498,518]', false, 12);
INSERT INTO public.filters VALUES ('Edmund Optics', '65703', 25.3999999999999986, 1, 'round', false, 7, '[536,556]', false, 13);
INSERT INTO public.filters VALUES ('Schott', '14406.3', 50, 1, 'round', false, 5, '[507,603]', false, 14);
INSERT INTO public.filters VALUES ('Edmund Optics', '65675', 25.3999999999999986, 1, 'round', false, 7, '[355,375]', false, 15);
INSERT INTO public.filters VALUES ('Semrock', '375/6 nm MaxDiode', 25.3999999999999986, 1, 'round', false, 5, '[370,380]', false, 16);
INSERT INTO public.filters VALUES ('Melles Griot', '03 FIV 107', 50, 1, 'round', false, 1, '[470,490]', false, 17);
INSERT INTO public.filters VALUES ('Melles Griot', '03 FIL 056', 25.3999999999999986, 1, 'round', false, 1, '[778,790]', false, 18);
INSERT INTO public.filters VALUES ('Semrock', 'TLP01-628', 25.3999999999999986, 1, 'rectangular', false, 6, '[495,628]', true, 19);
INSERT INTO public.filters VALUES ('Chroma', 'HQ630/60m', 25.3999999999999986, 1, 'round', false, 3, '[600,660]', false, 20);
INSERT INTO public.filters VALUES ('Melles Griot', '03 FIL 024', 25.3999999999999986, 1, 'round', false, 4, '[622.799999999999955,642.799999999999955]', false, 21);
INSERT INTO public.filters VALUES ('Semrock', 'LL01-633-12.5', 25.3999999999999986, 1, 'round', false, 5, '[631.600000000000023,634]', false, 22);
INSERT INTO public.filters VALUES ('Semrock', 'LPD02-633RU-25', 36, 1, 'round', false, 6, '[632.799999999999955,980.799999999999955]', false, 23);
INSERT INTO public.filters VALUES ('Semrock', 'LPD02-633RU-25x36x1.1', 36, 1, 'rectangular', false, 1, '[632.799999999999955,980.799999999999955]', false, 24);
INSERT INTO public.filters VALUES ('Thorlabs', 'FB640-10', 25.3999999999999986, 1, 'round', false, 7, '[630,650]', false, 25);
INSERT INTO public.filters VALUES ('Thorlabs', 'FES0650', 25.3999999999999986, 1, 'round', false, 1, '[440,650]', false, 26);
INSERT INTO public.filters VALUES ('Chroma', 'HQ655LP', 25.3999999999999986, 1, 'round', false, 1, '[655,800]', false, 27);
INSERT INTO public.filters VALUES ('Semrock', 'TSP01-704-25x36', 36, 1, 'round', false, 1, '[628,704]', true, 28);
INSERT INTO public.filters VALUES (NULL, NULL, 35, 1, 'round', false, 1, '[691,711]', false, 29);
INSERT INTO public.filters VALUES ('Chroma', 'D705/20m', 25.3999999999999986, 1, 'round', false, 1, '[695,715]', false, 30);
INSERT INTO public.filters VALUES ('Semrock', 'FF01-715/LP-25', 25, 1, 'round', false, 1, '[715,1200]', false, 31);
INSERT INTO public.filters VALUES ('Semrock', 'FF01-736/LP-25', 25, 1, 'round', false, 1, '[755,1200]', false, 32);
INSERT INTO public.filters VALUES ('Melles Griot', '03 FIL 256', 25.3999999999999986, 1, 'round', false, 8, '[776,786]', false, 33);
INSERT INTO public.filters VALUES ('Semrock', 'TSP01-790', 36, 1, 'rectangular', false, 1, '[704,790]', true, 34);
INSERT INTO public.filters VALUES ('Semrock', 'FF01-793/LP-25', 25.3999999999999986, 1, 'round', false, 1, '[807,852]', false, 35);
INSERT INTO public.filters VALUES ('Thorlabs', 'FEL0800', 25.3999999999999986, 1, 'round', false, 1, '[800,2150]', false, 36);
INSERT INTO public.filters VALUES ('Semrock', 'FF01-800/LP', 25.3999999999999986, 1, 'round', false, 1, '[815,915]', false, 37);
INSERT INTO public.filters VALUES ('Semrock', 'LP02-808RU-25', 25.3999999999999986, 1, 'round', false, 1, '[813.700000000000045,1900]', false, 38);
INSERT INTO public.filters VALUES ('Semrock', 'LL01-810-12.5', 25.3999999999999986, 1, 'round', false, 1, '[808.5,811.5]', false, 39);
INSERT INTO public.filters VALUES ('Semrock', 'LL01-830-12.5', 25.3999999999999986, 1, 'round', false, 1, '[828,831]', false, 40);
INSERT INTO public.filters VALUES ('Semrock', 'LP02-830RS-25', 25.3999999999999986, 1, 'round', false, 1, '[841.899999999999977,1900]', false, 41);
INSERT INTO public.filters VALUES ('Semrock', 'FF01-832/37-25', 25.3999999999999986, 1, 'round', false, 1, '[810,855]', false, 42);
INSERT INTO public.filters VALUES ('Melles Griot', 'F40-670-4-050', 12.6999999999999993, 2, 'round', false, 1, '[630,710]', false, 43);
INSERT INTO public.filters VALUES ('Semrock', 'FF801-Di02-25x36', 36, 2, 'rectangular', false, 1, '[801.5,1100]', false, 44);
INSERT INTO public.filters VALUES ('Melles Griot', '03 FIL 059', 25.3999999999999986, 1, 'round', false, 1, '[830,850]', false, 45);
INSERT INTO public.filters VALUES ('Semrock', 'FF01-842/56-25', 25.3999999999999986, 1, 'round', false, 1, '[810,875]', false, 46);
INSERT INTO public.filters VALUES ('Chroma', 'ET845/55m', 25.3999999999999986, 1, 'round', false, 1, '[790,900]', false, 47);
INSERT INTO public.filters VALUES ('Thorlabs', 'FEL0850', 25.3999999999999986, 1, 'round', false, 1, '[850,2150]', false, 48);
INSERT INTO public.filters VALUES ('Thorlabs', 'FB880-40', 25.3999999999999986, 1, 'round', false, 1, '[862,894]', false, 49);
INSERT INTO public.filters VALUES ('Thorlabs', 'FB880-70', 25.3999999999999986, 1, 'round', false, 1, '[850,920]', false, 50);
INSERT INTO public.filters VALUES ('Semrock', 'TSP01-887-25x36', 36, 1, 'rectangular', false, 1, '[790,887]', true, 51);
INSERT INTO public.filters VALUES ('Semrock', 'TLP01-887-25x36', 36, 1, 'rectangular', false, 1, '[790,887]', true, 52);
INSERT INTO public.filters VALUES ('Thorlabs', 'FEL0900', 25.3999999999999986, 1, 'round', false, 1, '[900,2150]', false, 53);
INSERT INTO public.filters VALUES (NULL, NULL, 25.3999999999999986, 1, 'round', false, 1, '[900,2000]', false, 54);
INSERT INTO public.filters VALUES ('Thorlabs', 'FES0900', 25.3999999999999986, 1, 'round', false, 1, '[600,900]', false, 55);
INSERT INTO public.filters VALUES (NULL, '9030', 25.3999999999999986, 1, 'round', false, 1, '[878,928]', false, 56);
INSERT INTO public.filters VALUES ('Coherent', '35-4712-000', 50, 1, 'square', false, 1, NULL, false, 57);
INSERT INTO public.filters VALUES ('Semrock', 'LP02-980RU-25', 50, 1, 'rectangular', false, 1, '[987.700000000000045,2000]', false, 58);
INSERT INTO public.filters VALUES ('Thorlabs', 'FES1000', 25.3999999999999986, 1, 'round', false, 1, '[700,1000]', false, 59);
INSERT INTO public.filters VALUES (NULL, NULL, 30, 1, 'round', false, 1, '[1000,2000]', false, 60);
INSERT INTO public.filters VALUES (NULL, NULL, 78.7399999999999949, 1, 'round', false, 1, '[1020,2000]', false, 61);
INSERT INTO public.filters VALUES (NULL, NULL, 35, 1, 'round', false, 1, '[1055,1065]', false, 62);
INSERT INTO public.filters VALUES ('Thorlabs', 'FEL1250', 25.3999999999999986, 1, 'round', false, 1, '[1250,2150]', false, 63);
INSERT INTO public.filters VALUES ('Thorlabs', 'FEL1500', 25.3999999999999986, 1, 'round', false, 1, '[1500,2150]', false, 64);
INSERT INTO public.filters VALUES ('MidOpt', 'BP540/25', 25.3999999999999986, 1, 'round', true, 3, '[509,572]', false, 65);
INSERT INTO public.filters VALUES ('Chroma', 'AT435/20x', 25.3999999999999986, 1, 'round', true, 3, '[425,445]', false, 66);
INSERT INTO public.filters VALUES ('Chroma', 'ET402/15x', 25.3999999999999986, 1, 'round', true, 3, '[394.5,409.5]', false, 67);
INSERT INTO public.filters VALUES ('Chroma', 'ET380x', 25.3999999999999986, 1, 'round', true, 3, '[374.5,385.5]', false, 68);
INSERT INTO public.filters VALUES ('Chroma', 'ET365/10x', 25.3999999999999986, 1, 'round', true, 3, '[360,370]', false, 69);
INSERT INTO public.filters VALUES ('Chroma', 'ET340x', 25.3999999999999986, 1, 'round', true, 3, '[334.5,345.5]', false, 70);
INSERT INTO public.filters VALUES ('Chroma', 'ET300/10BP', 25.3999999999999986, 1, 'round', true, 3, '[295,305]', false, 71);
INSERT INTO public.filters VALUES ('Chroma', 'ET270/15BP', 25.3999999999999986, 1, 'round', true, 3, '[262.5,277.5]', false, 72);
INSERT INTO public.filters VALUES ('Chroma', 'ET254/10BP', 25.3999999999999986, 1, 'round', true, 3, '[249,259]', false, 73);
INSERT INTO public.filters VALUES ('Chroma', 'ET220/10BP', 25.3999999999999986, 1, 'round', true, 3, '[215,225]', false, 74);


--
-- Data for Name: lasers; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.lasers VALUES (NULL, NULL, 1, NULL, NULL, 1, 180, 3, 970, 1);
INSERT INTO public.lasers VALUES ('Roithner Lasertechnik', 'VLM650-00', 4, NULL, NULL, 1, 3, 2.60000000000000009, 650, 2);
INSERT INTO public.lasers VALUES ('Roithner Lasertechnik', 'VLM650-00', 2, NULL, NULL, 1, 5, 5, 650, 3);
INSERT INTO public.lasers VALUES ('Roithner Lasertechnik', 'RLDH830-30-3', 1, NULL, NULL, 1, 30, 3, 830, 4);
INSERT INTO public.lasers VALUES ('Roithner Lasertechnik', 'RLDH660-40-3', 1, NULL, NULL, 1, 40, 3, 655, 5);
INSERT INTO public.lasers VALUES (NULL, NULL, 1, NULL, NULL, 1, NULL, 3, 660, 6);
INSERT INTO public.lasers VALUES (NULL, NULL, 1, NULL, NULL, 1, NULL, 1, 640, 7);
INSERT INTO public.lasers VALUES ('Roithner Lasertechnik', 'LMD635', 1, NULL, NULL, 1, 5, 5, 635, 8);
INSERT INTO public.lasers VALUES ('Roithner Lasertechnik', 'RLDB808', 1, NULL, NULL, 1, 500, 5, 808, 9);
INSERT INTO public.lasers VALUES ('Roithner Lasertechnik', 'RLDH808-1200-5', 1, NULL, NULL, 1, 1200, 5, 808, 10);
INSERT INTO public.lasers VALUES ('Roithner Lasertechnik', 'RLT1300-30G', 1, NULL, NULL, 1, 30, 2, 1300, 11);


--
-- Data for Name: leds; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.leds VALUES ('Lumex', 'SLX-LX5093UWC/C', NULL, 5, NULL, NULL, 1, 'empty', 'Blanche', 3.39999999999999991, 20, NULL, 1);
INSERT INTO public.leds VALUES ('Luxeon', 'LXHL-NRR8', NULL, 4, NULL, NULL, 1, 'empty', 'Bleue', 3.41999999999999993, 350, 220, 2);
INSERT INTO public.leds VALUES ('Cree', 'MLEAWT-A1-R250-0004E5', NULL, 5, NULL, NULL, 1, NULL, 'Blanche', 3.20000000000000018, 150, 630, 3);
INSERT INTO public.leds VALUES ('VCC', 'VAOL-10GWY4', NULL, 5, NULL, NULL, 1, 'empty', 'Blanche', 3.5, 20, 18, 4);
INSERT INTO public.leds VALUES ('Cree', 'MLEBLU-A1-0000-000T01', NULL, 5, NULL, NULL, 1, NULL, 'Bleue', 3.20000000000000018, 150, 115, 5);
INSERT INTO public.leds VALUES ('Broadcom', 'HLMP-C515', NULL, 10, NULL, NULL, 1, 'empty', 'Verte', 2.20000000000000018, 20, 107, 6);
INSERT INTO public.leds VALUES ('Rohm', 'SML-S13RTT86', NULL, 5, NULL, NULL, 1, 'empty', NULL, 1.39999999999999991, 20, 2.5, 7);
INSERT INTO public.leds VALUES ('Lumileds', 'L1T2-4070000000000', NULL, 5, NULL, NULL, 1, NULL, 'Blanche', 2.85999999999999988, 1000, 1735, 8);
INSERT INTO public.leds VALUES ('Luxeon', 'SR-01-H2070', NULL, 1, NULL, NULL, 1, 'empty', 'Rouge', 2.10000000000000009, 700, 1600, 9);
INSERT INTO public.leds VALUES (NULL, 'C-03-E12-17A', NULL, 1, NULL, NULL, 1, 'empty', 'Violette', NULL, NULL, NULL, 10);
INSERT INTO public.leds VALUES (NULL, 'C-03-C12-15A', NULL, 3, NULL, NULL, 1, 'empty', 'Violette', NULL, NULL, NULL, 11);
INSERT INTO public.leds VALUES (NULL, 'C-03-A12-27A', NULL, 3, NULL, NULL, 1, 'empty', 'Turquoise', NULL, NULL, NULL, 12);
INSERT INTO public.leds VALUES ('Roithner Lasertechnik', 'APG2C1-505', NULL, 1, NULL, NULL, 1, 'empty', 'Turquoise', 6.79999999999999982, 500, 130, 13);
INSERT INTO public.leds VALUES ('Roithner Lasertechnik', 'APG2C1-505', NULL, 1, NULL, NULL, 1, 'empty', 'Turquoise', 6.79999999999999982, 500, 130, 14);
INSERT INTO public.leds VALUES (NULL, NULL, NULL, 1, NULL, NULL, 1, NULL, 'Violette', 3, 500, NULL, 15);


--
-- Data for Name: lenses; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.lenses VALUES ('Newport', 'M-20X', 25.3999999999999986, 1, 'round', true, NULL, 1, '[400,800]', 'microscope', '[400,800]', 9, 1);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LC1054', 12.6999999999999993, 1, 'round', false, NULL, 1, '[350,2000]', 'unmounted', '[400,800]', -25, 2);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LJ1598L1-A', 12.6999999999999993, 1, 'round', false, NULL, 1, '[400,800]', 'cylindrical', '[400,800]', 3.9000001, 3);
INSERT INTO public.lenses VALUES ('Thorlabs', 'A240-B', 9.9399999999999995, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[650,1050]', 8, 4);
INSERT INTO public.lenses VALUES ('Edmund Optics', '43-985', 10.5, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,2500]', 9.5, 5);
INSERT INTO public.lenses VALUES ('Thorlabs', 'AC050-010-B', 5, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[400,700]', 10, 6);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1576', 9, 3, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,2000]', 12, 7);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1576-C', 9, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[1050,1700]', 12, 8);
INSERT INTO public.lenses VALUES ('Edmund Optics', '46-660', 15, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,2500]', 12, 9);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1472', 9, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,2000]', 20, 10);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1700-A', 6, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,700]', 30, 11);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1422', 25.3999999999999986, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,2000]', 40, 12);
INSERT INTO public.lenses VALUES ('Thorlabs', 'ACL5040-DG15-A', 50, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,700]', 40, 13);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1255-C', 25, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[1050,1700]', 50, 14);
INSERT INTO public.lenses VALUES ('Melles Griot', '01LPX011', 10, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,700]', 15, 15);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1401', 50.7999999999999972, 2, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,2000]', 60, 16);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LB1309-A', 50.7999999999999972, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,700]', 75, 17);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LB4330-UV', 25.3999999999999986, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[245,400]', 75, 18);
INSERT INTO public.lenses VALUES ('Thorlabs', 'AC254-100-A', 25.3999999999999986, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,700]', 100, 19);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1050', 50.7999999999999972, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,2000]', 100, 20);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1251-C', 25.3999999999999986, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[1050,1700]', 100, 21);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LB1676-A', 25.3999999999999986, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,700]', 100, 22);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1289-A', 12.6999999999999993, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,700]', 30, 23);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1304-A', 12.6999999999999993, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,700]', 40, 24);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LBF254-100', 25.3999999999999986, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,2600]', 100, 25);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LSM05-BB', 59.5, 1, 'round', false, NULL, 1, '[400,800]', 'scan', '[810,1100]', 100, 26);
INSERT INTO public.lenses VALUES ('Thorlabs', 'F240SMA-780', 10, 1, 'round', false, 'SMA', 1, '[400,800]', 'collimator', '[600,1050]', 8, 27);
INSERT INTO public.lenses VALUES ('Thorlabs', 'AC127-075-B', 12.6999999999999993, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[650,1050]', 75, 28);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1986-C', 25.3999999999999986, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[1050,1700]', 125, 29);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1608-C', 25.3999999999999986, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[1050,1700]', 75, 30);
INSERT INTO public.lenses VALUES ('J. Fichou', 'PLCX-25.4-170-UV', 25.3999999999999986, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[185,2100]', 170, 31);
INSERT INTO public.lenses VALUES ('Coherent', '45-2185', 27.8999999999999986, 2, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[500,22000]', 88.9000015, 32);
INSERT INTO public.lenses VALUES ('Melles Griot', '01LPX267', 22.3000000000000007, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,700]', 200, 33);
INSERT INTO public.lenses VALUES ('Melles Griot', '06LAI003/169', 10, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,700]', 10, 34);
INSERT INTO public.lenses VALUES ('Thorlabs', 'TC06APC-1064', 12, 1, 'round', false, NULL, 1, '[400,800]', 'collimator', '[1050,1650]', 6.11999989, 35);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1289-B', 12.6999999999999993, 1, 'round', false, 'unmounted', 1, '[400,800]', 'unmounted', '[650,1050]', 30, 36);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1608-B', 25.3999999999999986, 1, 'round', false, 'unknown', 1, '[400,800]', 'unmounted', '[650,1050]', 75, 37);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1986-B', 25.3999999999999986, 1, 'round', false, 'unmounted', 1, '[400,800]', 'unmounted', '[650,1050]', 125, 38);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1131', 25.3999999999999986, 2, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,2000]', 50, 39);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1433-A', 25.3999999999999986, 2, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,700]', 150, 40);
INSERT INTO public.lenses VALUES ('Thorlabs', 'C110TME-B', 25.3999999999999986, 2, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[650,1050]', 6.23999977, 41);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LJ1598L1-C', NULL, 2, 'round', false, NULL, 1, '[400,800]', 'cylindrical', '[1050,1700]', 3.9000001, 42);
INSERT INTO public.lenses VALUES ('Thorlabs', 'AC050-008-C-ML', 5, 1, 'round', false, 'M9', 1, '[400,800]', 'achromatic doublet', '[1050,1620]', 7.5, 43);
INSERT INTO public.lenses VALUES ('Thorlabs', 'AC254-500-B-ML', 25.3999999999999986, 1, 'round', false, 'SM1', 1, '[400,800]', 'achromatic doublet', '[650,1050]', 500, 44);
INSERT INTO public.lenses VALUES ('Thorlabs', 'AC254-300-B-ML', 25.3999999999999986, 1, 'round', false, 'SM1', 1, '[400,800]', 'achromatic doublet', '[650,1050]', 300, 45);
INSERT INTO public.lenses VALUES ('Thorlabs', 'F240APC-C', 12, 2, 'round', false, 'FC/APC', 1, '[400,800]', 'collimator', '[1050,1620]', 8.13000011, 46);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LJ1212L1-C', NULL, 1, 'square', false, 'unmounted', 1, '[400,800]', 'cylindrical', '[1050,1700]', 30, 47);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LBF254-200-A', 25.3999999999999986, 1, 'round', false, 'unmounted', 1, '[400,800]', 'unmounted', '[350,700]', 200, 48);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LBF254-100-A', 25.3999999999999986, 1, 'round', false, 'unmounted', 1, '[400,800]', 'unmounted', '[350,700]', 100, 49);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LC2067-B', 9, 1, 'round', false, 'unknown', 1, '[400,800]', 'unmounted', '[650,1050]', -9, 50);
INSERT INTO public.lenses VALUES ('Thorlabs', 'TC06APC-1310', 25.3999999999999986, 1, 'round', false, 'FC/APC', 1, '[1310,1310]', 'collimator', '[1310,1310]', 6.1500001, 51);
INSERT INTO public.lenses VALUES ('Thorlabs', 'TC12FC-780', 7, 1, 'round', false, 'FC/PC', 1, '[768,792]', 'collimator', '[650,1050]', 12.1899996, 52);
INSERT INTO public.lenses VALUES ('Thorlabs', 'AL1210M-B', 12.5, 1, 'round', false, 'SM05', 1, '[380,2000]', 'collimator', '[650,1050]', 10, 53);
INSERT INTO public.lenses VALUES ('Thorlabs', 'C350TMD-B', 4.70000000000000018, 1, 'round', false, 'M9', 1, '[350,2100]', 'unmounted', '[600,1050]', 4.5, 54);
INSERT INTO public.lenses VALUES ('Olympus', 'PLN10X', 24, 1, 'round', false, 'RMS', 2, '[400,800]', 'microscope', '[400,800]', 18, 55);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA4102', 25.3999999999999986, 1, 'round', false, 'unmounted', 1, '[185,2100]', 'unmounted', NULL, 200, 56);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LJ1125L1-A', 25.3999999999999986, 1, 'round', false, 'unmounted', 4, '[300,2200]', 'cylindrical', '[350,700]', 40, 57);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LJ1567RM', 25.3999999999999986, 1, 'round', false, 'SM1', 4, '[300,2200]', 'cylindrical', NULL, 100, 58);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LJ1695RM', 25.3999999999999986, 1, 'round', false, 'SM1', 4, '[300,2200]', 'cylindrical', NULL, 50, 59);
INSERT INTO public.lenses VALUES ('Thorlabs', 'LA1986-ML', 25.3999999999999986, 1, 'round', false, 'SM1', 4, '[300,2200]', 'unmounted', NULL, 125, 60);
INSERT INTO public.lenses VALUES ('Olympus', 'LMPLN10XIR', 19, 1, 'round', false, 'RMS', 2, '[700,1300]', 'microscope', NULL, NULL, 61);
INSERT INTO public.lenses VALUES ('Olympus', 'ACHN10XP', NULL, 1, 'round', false, 'RMS', 2, NULL, 'microscope', NULL, NULL, 62);
INSERT INTO public.lenses VALUES (NULL, 'Unknown', 10, 4, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,700]', 10, 63);
INSERT INTO public.lenses VALUES (NULL, 'Unknown', 41.8999999999999986, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,700]', 350, 64);
INSERT INTO public.lenses VALUES (NULL, 'Unknown', 10, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,700]', 15, 65);
INSERT INTO public.lenses VALUES (NULL, 'Unknown', 12.6999999999999993, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,700]', 20, 66);
INSERT INTO public.lenses VALUES (NULL, 'Unknown', 12.6999999999999993, 1, 'round', false, NULL, 1, '[400,800]', 'unmounted', '[350,700]', 10, 67);


--
-- Data for Name: lensmount; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.lensmount VALUES ('unmounted');
INSERT INTO public.lensmount VALUES ('SMA');
INSERT INTO public.lensmount VALUES ('FC/APC');
INSERT INTO public.lensmount VALUES ('unknown');
INSERT INTO public.lensmount VALUES ('SM1');
INSERT INTO public.lensmount VALUES ('M9');
INSERT INTO public.lensmount VALUES ('FC/PC');
INSERT INTO public.lensmount VALUES ('SM05');
INSERT INTO public.lensmount VALUES ('RMS');


--
-- Data for Name: lenstype; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.lenstype VALUES ('cylindrical');
INSERT INTO public.lenstype VALUES ('microscope');
INSERT INTO public.lenstype VALUES ('collimator');
INSERT INTO public.lenstype VALUES ('unmounted');
INSERT INTO public.lenstype VALUES ('scan');
INSERT INTO public.lenstype VALUES ('achromatic doublet');


--
-- Data for Name: localisations; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.localisations VALUES (1, '04 3008', 'Stock');
INSERT INTO public.localisations VALUES (2, '04 3008', 'Agui');
INSERT INTO public.localisations VALUES (3, '04 3007', 'Mylène Sauty');
INSERT INTO public.localisations VALUES (4, NULL, 'Alistair Rowe');
INSERT INTO public.localisations VALUES (5, NULL, 'Wiebke Hann');
INSERT INTO public.localisations VALUES (6, '04 3008', 'Sangjun Park');
INSERT INTO public.localisations VALUES (7, NULL, 'Physics department');
INSERT INTO public.localisations VALUES (8, NULL, 'Unknown');


--
-- Data for Name: manufacturers; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.manufacturers VALUES ('Thorlabs');
INSERT INTO public.manufacturers VALUES ('Newport');
INSERT INTO public.manufacturers VALUES ('Olympus');
INSERT INTO public.manufacturers VALUES ('Coherent');
INSERT INTO public.manufacturers VALUES ('Edmund Optics');
INSERT INTO public.manufacturers VALUES ('J. Fichou');
INSERT INTO public.manufacturers VALUES ('Melles Griot');
INSERT INTO public.manufacturers VALUES ('Lumex');
INSERT INTO public.manufacturers VALUES ('Luxeon');
INSERT INTO public.manufacturers VALUES ('Cree');
INSERT INTO public.manufacturers VALUES ('VCC');
INSERT INTO public.manufacturers VALUES ('Broadcom');
INSERT INTO public.manufacturers VALUES ('Rohm');
INSERT INTO public.manufacturers VALUES ('Lumileds');
INSERT INTO public.manufacturers VALUES ('Chroma');
INSERT INTO public.manufacturers VALUES ('Schott');
INSERT INTO public.manufacturers VALUES ('Semrock');
INSERT INTO public.manufacturers VALUES ('Roithner Lasertechnik');
INSERT INTO public.manufacturers VALUES ('MidOpt');


--
-- Data for Name: mirrors; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.mirrors VALUES ('Thorlabs', 'BB01-E03', 25.3999999999999986, 1, 'round', false, 1, '[750,1100]', 1);
INSERT INTO public.mirrors VALUES ('Thorlabs', 'BB01-E03', 25.3999999999999986, 1, 'round', false, 6, '[750,1100]', 2);
INSERT INTO public.mirrors VALUES ('Thorlabs', 'PF10-03-F01', 25.3999999999999986, 9, 'round', false, 1, '[250,450]', 3);
INSERT INTO public.mirrors VALUES ('Thorlabs', 'PFD10-03-F01', 25.3999999999999986, 2, 'D', false, 1, '[250,450]', 4);
INSERT INTO public.mirrors VALUES ('Melles Griot', '02MFG017', 38, 1, 'round', false, 1, '[400,800]', 5);
INSERT INTO public.mirrors VALUES ('Thorlabs', 'PF05-03-F01', 12.6999999999999993, 6, 'round', false, 1, '[250,450]', 6);
INSERT INTO public.mirrors VALUES ('Coherent', '45-3241-000', 38, 1, 'round', false, 1, '[9400,10600]', 7);
INSERT INTO public.mirrors VALUES ('Coherent', '45-3241-000', 38, 2, 'round', false, 5, '[9400,10600]', 8);


--
-- Data for Name: polarizers; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.polarizers VALUES ('Thorlabs', 'LPUV050', 12.5, 1, 'round', NULL, 1, '[365,395]', NULL, 1);
INSERT INTO public.polarizers VALUES ('Thorlabs', 'LPNIR050', 12.5, 2, 'round', NULL, 1, '[650,2000]', NULL, 2);


--
-- Data for Name: polarizertype; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.polarizertype VALUES ('Normal');
INSERT INTO public.polarizertype VALUES ('Glan-Taylor');


--
-- Data for Name: shapes; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.shapes VALUES ('cubic');
INSERT INTO public.shapes VALUES ('round');
INSERT INTO public.shapes VALUES ('rectangular');
INSERT INTO public.shapes VALUES ('square');
INSERT INTO public.shapes VALUES ('D');


--
-- Data for Name: waveplates; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.waveplates VALUES ('Thorlabs', 'AQWP05M-600', 25.3999999999999986, 1, 'round', NULL, 6, '[540,775]', 'quarter-wave', '[400,800]', 1);
INSERT INTO public.waveplates VALUES ('Melles Griot', '02WRC033/633', 25.3999999999999986, 1, 'round', NULL, 1, '[633,634)', 'quarter-wave', NULL, 2);
INSERT INTO public.waveplates VALUES ('Thorlabs', 'WPMQ05M-1064', 12.6999999999999993, 1, 'round', NULL, 1, '[1060,1070]', 'quarter-wave', NULL, 3);
INSERT INTO public.waveplates VALUES ('Thorlabs', 'AQWP05M-1600', 12.6999999999999993, 1, 'round', NULL, 1, '[1300,1875]', 'quarter-wave', '[1100,2000]', 4);
INSERT INTO public.waveplates VALUES ('Melles Griot', '02WRC023/780', 25.3999999999999986, 2, 'round', NULL, 1, '[780,781)', 'half-wave', NULL, 5);


--
-- Data for Name: waveplatetype; Type: TABLE DATA; Schema: public; Owner: sirc
--

INSERT INTO public.waveplatetype VALUES ('half-wave');
INSERT INTO public.waveplatetype VALUES ('quarter-wave');


--
-- Name: beamsplitters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.beamsplitters_id_seq', 12, true);


--
-- Name: beamsplitters_localisation_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.beamsplitters_localisation_seq', 1, false);


--
-- Name: filters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.filters_id_seq', 74, true);


--
-- Name: filters_localisation_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.filters_localisation_seq', 6, true);


--
-- Name: lasers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.lasers_id_seq', 11, true);


--
-- Name: lasers_localisation_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.lasers_localisation_seq', 1, false);


--
-- Name: leds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.leds_id_seq', 15, true);


--
-- Name: leds_localisation_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.leds_localisation_seq', 1, false);


--
-- Name: lenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.lenses_id_seq', 67, true);


--
-- Name: lenses_localisation_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.lenses_localisation_seq', 1, false);


--
-- Name: localisations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.localisations_id_seq', 3, true);


--
-- Name: mirrors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.mirrors_id_seq', 8, true);


--
-- Name: mirrors_localisation_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.mirrors_localisation_seq', 1, false);


--
-- Name: polarizer_localisation_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.polarizer_localisation_seq', 1, false);


--
-- Name: polarizers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.polarizers_id_seq', 2, true);


--
-- Name: waveplates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.waveplates_id_seq', 5, true);


--
-- Name: waveplates_localisation_seq; Type: SEQUENCE SET; Schema: public; Owner: sirc
--

SELECT pg_catalog.setval('public.waveplates_localisation_seq', 1, false);


--
-- Name: __diesel_schema_migrations __diesel_schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.__diesel_schema_migrations
    ADD CONSTRAINT __diesel_schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: beamsplitters beamsplitters_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.beamsplitters
    ADD CONSTRAINT beamsplitters_pkey PRIMARY KEY (id);


--
-- Name: beamsplittertype beamsplittertype_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.beamsplittertype
    ADD CONSTRAINT beamsplittertype_pkey PRIMARY KEY (name);


--
-- Name: filters filters_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.filters
    ADD CONSTRAINT filters_pkey PRIMARY KEY (id);


--
-- Name: lasers lasers_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.lasers
    ADD CONSTRAINT lasers_pkey PRIMARY KEY (id);


--
-- Name: leds leds_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.leds
    ADD CONSTRAINT leds_pkey PRIMARY KEY (id);


--
-- Name: lenses lenses_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.lenses
    ADD CONSTRAINT lenses_pkey PRIMARY KEY (id);


--
-- Name: lensmount lensmount_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.lensmount
    ADD CONSTRAINT lensmount_pkey PRIMARY KEY (name);


--
-- Name: lenstype lenstype_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.lenstype
    ADD CONSTRAINT lenstype_pkey PRIMARY KEY (name);


--
-- Name: localisations localisations_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.localisations
    ADD CONSTRAINT localisations_pkey PRIMARY KEY (id);


--
-- Name: manufacturers manufacturers_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT manufacturers_pkey PRIMARY KEY (name);


--
-- Name: mirrors mirrors_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.mirrors
    ADD CONSTRAINT mirrors_pkey PRIMARY KEY (id);


--
-- Name: polarizers polarizers_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.polarizers
    ADD CONSTRAINT polarizers_pkey PRIMARY KEY (id);


--
-- Name: polarizertype polarizertype_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.polarizertype
    ADD CONSTRAINT polarizertype_pkey PRIMARY KEY (name);


--
-- Name: shapes shapes_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.shapes
    ADD CONSTRAINT shapes_pkey PRIMARY KEY (name);


--
-- Name: waveplates waveplates_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.waveplates
    ADD CONSTRAINT waveplates_pkey PRIMARY KEY (id);


--
-- Name: waveplatetype waveplatetype_pkey; Type: CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.waveplatetype
    ADD CONSTRAINT waveplatetype_pkey PRIMARY KEY (name);


--
-- Name: beamsplitters beamsplitters_localisation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.beamsplitters
    ADD CONSTRAINT beamsplitters_localisation_fkey FOREIGN KEY (localisation) REFERENCES public.localisations(id);


--
-- Name: beamsplitters beamsplitters_manufacturer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.beamsplitters
    ADD CONSTRAINT beamsplitters_manufacturer_fkey FOREIGN KEY (manufacturer) REFERENCES public.manufacturers(name);


--
-- Name: beamsplitters beamsplitters_model_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.beamsplitters
    ADD CONSTRAINT beamsplitters_model_type_fkey FOREIGN KEY (model_type) REFERENCES public.beamsplittertype(name);


--
-- Name: beamsplitters beamsplitters_shape_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.beamsplitters
    ADD CONSTRAINT beamsplitters_shape_fkey FOREIGN KEY (shape) REFERENCES public.shapes(name);


--
-- Name: filters filters_localisation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.filters
    ADD CONSTRAINT filters_localisation_fkey FOREIGN KEY (localisation) REFERENCES public.localisations(id);


--
-- Name: filters filters_manufacturer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.filters
    ADD CONSTRAINT filters_manufacturer_fkey FOREIGN KEY (manufacturer) REFERENCES public.manufacturers(name);


--
-- Name: filters filters_shape_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.filters
    ADD CONSTRAINT filters_shape_fkey FOREIGN KEY (shape) REFERENCES public.shapes(name);


--
-- Name: lasers lasers_localisation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.lasers
    ADD CONSTRAINT lasers_localisation_fkey FOREIGN KEY (localisation) REFERENCES public.localisations(id);


--
-- Name: lasers lasers_manufacturer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.lasers
    ADD CONSTRAINT lasers_manufacturer_fkey FOREIGN KEY (manufacturer) REFERENCES public.manufacturers(name);


--
-- Name: lasers lasers_shape_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.lasers
    ADD CONSTRAINT lasers_shape_fkey FOREIGN KEY (shape) REFERENCES public.shapes(name);


--
-- Name: leds leds_localisation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.leds
    ADD CONSTRAINT leds_localisation_fkey FOREIGN KEY (localisation) REFERENCES public.localisations(id);


--
-- Name: leds leds_manufacturer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.leds
    ADD CONSTRAINT leds_manufacturer_fkey FOREIGN KEY (manufacturer) REFERENCES public.manufacturers(name);


--
-- Name: leds leds_shape_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.leds
    ADD CONSTRAINT leds_shape_fkey FOREIGN KEY (shape) REFERENCES public.shapes(name);


--
-- Name: lenses lenses_localisation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.lenses
    ADD CONSTRAINT lenses_localisation_fkey FOREIGN KEY (localisation) REFERENCES public.localisations(id);


--
-- Name: lenses lenses_manufacturer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.lenses
    ADD CONSTRAINT lenses_manufacturer_fkey FOREIGN KEY (manufacturer) REFERENCES public.manufacturers(name);


--
-- Name: lenses lenses_model_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.lenses
    ADD CONSTRAINT lenses_model_type_fkey FOREIGN KEY (model_type) REFERENCES public.lenstype(name);


--
-- Name: lenses lenses_mount_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.lenses
    ADD CONSTRAINT lenses_mount_type_fkey FOREIGN KEY (mount_type) REFERENCES public.lensmount(name);


--
-- Name: lenses lenses_shape_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.lenses
    ADD CONSTRAINT lenses_shape_fkey FOREIGN KEY (shape) REFERENCES public.shapes(name);


--
-- Name: mirrors mirrors_localisation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.mirrors
    ADD CONSTRAINT mirrors_localisation_fkey FOREIGN KEY (localisation) REFERENCES public.localisations(id);


--
-- Name: mirrors mirrors_manufacturer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.mirrors
    ADD CONSTRAINT mirrors_manufacturer_fkey FOREIGN KEY (manufacturer) REFERENCES public.manufacturers(name);


--
-- Name: mirrors mirrors_shape_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.mirrors
    ADD CONSTRAINT mirrors_shape_fkey FOREIGN KEY (shape) REFERENCES public.shapes(name);


--
-- Name: polarizers polarizer_localisation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.polarizers
    ADD CONSTRAINT polarizer_localisation_fkey FOREIGN KEY (localisation) REFERENCES public.localisations(id);


--
-- Name: polarizers polarizer_manufacturer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.polarizers
    ADD CONSTRAINT polarizer_manufacturer_fkey FOREIGN KEY (manufacturer) REFERENCES public.manufacturers(name);


--
-- Name: polarizers polarizer_model_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.polarizers
    ADD CONSTRAINT polarizer_model_type_fkey FOREIGN KEY (model_type) REFERENCES public.polarizertype(name);


--
-- Name: polarizers polarizer_shape_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.polarizers
    ADD CONSTRAINT polarizer_shape_fkey FOREIGN KEY (shape) REFERENCES public.shapes(name);


--
-- Name: waveplates waveplates_localisation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.waveplates
    ADD CONSTRAINT waveplates_localisation_fkey FOREIGN KEY (localisation) REFERENCES public.localisations(id);


--
-- Name: waveplates waveplates_manufacturer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.waveplates
    ADD CONSTRAINT waveplates_manufacturer_fkey FOREIGN KEY (manufacturer) REFERENCES public.manufacturers(name);


--
-- Name: waveplates waveplates_model_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.waveplates
    ADD CONSTRAINT waveplates_model_type_fkey FOREIGN KEY (model_type) REFERENCES public.waveplatetype(name);


--
-- Name: waveplates waveplates_shape_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sirc
--

ALTER TABLE ONLY public.waveplates
    ADD CONSTRAINT waveplates_shape_fkey FOREIGN KEY (shape) REFERENCES public.shapes(name);


--
-- PostgreSQL database dump complete
--

