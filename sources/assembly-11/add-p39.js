const fs = require('fs');
let rawmeta = fs.readFileSync('meta.json');
let meta = JSON.parse(rawmeta);

module.exports = (id, district, startdate, enddate) => {
  qualifier = { }
  if(meta.term) qualifier['P2937'] = meta.term
  if(startdate) qualifier['P580']  = startdate
  if(enddate)   qualifier['P582']  = enddate
  if(district)  qualifier['P768']  = district

  return {
    id,
    claims: {
      P39: {
        value: meta.position,
        qualifiers: qualifier,
        references: { P4656: meta.source }
      }
    }
  }
}
