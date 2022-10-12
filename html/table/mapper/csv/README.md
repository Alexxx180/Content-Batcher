# CSV Mapper

Map no header csv data to HTML + CSS tables.

## Use

```
run.bat <input file> <output file> <delimiter> [trim chars]
```

```
run.bat input.csv output.html ","
```

## Configuration

You can set substrings to render as:
- [ways](config/ways.cfg)
- [walls](config/walls.cfg)
- [areas](config/areas.cfg)

## Rendering

You can set CSS classes to be defined as:
- [borders](classes/borders.txt)
- [highlight areas](classes/areas.txt)