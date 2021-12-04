const fs = require('fs');
const readline = require('readline');

async function processLineByLine() {
  const fileStream = fs.createReadStream('data/02');

  const rl = readline.createInterface({
    input: fileStream,
    crlfDelay: Infinity
  });
  // Note: we use the crlfDelay option to recognize all instances of CR LF
  // ('\r\n') in input.txt as a single line break.

  let lines = [];

  for await (const line of rl) {
    // Each line in input.txt will be successively available here as `line`.
    lines.push(line)
  }
  return lines;
}

function first() {
  processLineByLine().then((lines) => {
    let horz = 0;
    let vert = 0;
    for (const line of lines) {
      let [dirn, dist] = line.trim().split(" ");
      switch (dirn) {
        case "forward":
          horz += parseInt(dist);
          break;
        case "down":
          vert += parseInt(dist);
          break;
        case "up":
          vert -= parseInt(dist);
          break;
        default:
          throw Error(`bad value ${dirn}`);
      }
    }
    console.log("ex2 pt 1", horz, vert, horz * vert);
  })
}

function second() {
  processLineByLine().then((lines) => {
    let horz = 0;
    let aim = 0;
    let vert = 0;
    for (const line of lines) {
      let [dirn, distStr] = line.trim().split(" ");
      const dist = parseInt(distStr);
      switch (dirn) {
        case "forward":
          horz += dist;
          vert += aim * dist;
          break;
        case "down":
          aim += dist;
          break;
        case "up":
          aim -= dist;
          break;
        default:
          throw Error(`bad value ${dirn}`);
      }
    }
    console.log("ex2 pt2", horz, vert, horz * vert);
  })
}

first()
second()
