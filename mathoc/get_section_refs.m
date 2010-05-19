function srs = get_section_refs( )
global sections__
srs = map(@(x) [x 'ref'],sections__);
