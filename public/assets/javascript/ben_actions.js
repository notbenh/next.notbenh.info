// Generated by CoffeeScript 1.6.3
var LINK, NYI, auto_url_open, ben_actions, getRandomInt;

auto_url_open = function(result) {
  var result_url_match;
  result_url_match = /https?:\/\/(?:(?!&[^;]+;)[^\s:"'<>)])+/g.exec(result);
  if (result_url_match !== null && result_url_match[0] === result) {
    window.open(result);
    result += ' [opened in new tab]';
  }
  return result;
};

getRandomInt = function(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
};

LINK = function(url, note) {
  return [
    function() {
      return url;
    }, note + ' [[b;;;][opens in a new tab or window]]'
  ];
};

NYI = function(note) {
  return [
    function() {
      return 'not yet implemented';
    }, "[not yet implemented] " + note
  ];
};

ben_actions = {
  tdone: NYI('todo list manager'),
  suggest: LINK('https://github.com/notbenh/next.notbenh.info/issues', 'suggest issues via github'),
  resume: LINK('http://resume.notbenh.info', 'my resume'),
  about: LINK('http://about.notbenh.info', 'about me'),
  twitter: LINK('http://twitter.com/notbenh', 'my twitter account'),
  github: LINK('https://github.com/notbenh', 'my github account'),
  blog: LINK('http://notbenh.github.io', 'the thing I call a blog'),
  roll: [
    function(dice) {
      var count, die, die_max, i, max, min, parse, parse_die, results, roll, roll_total, total, _i, _j, _len, _ref, _ref1, _ref2;
      if (dice.length === 0 || dice === void 0) {
        return this.help('roll');
      }
      results = [];
      parse_die = /^(\d*)?d(\d+)/;
      roll_total = 0;
      console.info(dice);
      _ref = dice.split(' ');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        die = _ref[_i];
        console.info("DIE " + die);
        if (die === 'barrel') {
          results.push('[[;;;donkykong] ]');
        } else {
          parse = parse_die.exec(die);
          count = (_ref1 = parse[1]) != null ? _ref1 : 1;
          die_max = (_ref2 = parse[2]) != null ? _ref2 : 2;
          total = 0;
          min = 1;
          max = 0;
          for (i = _j = 1; 1 <= count ? _j <= count : _j >= count; i = 1 <= count ? ++_j : --_j) {
            roll = getRandomInt(1, die_max);
            total += roll;
            if (roll < min) {
              min = roll;
            }
            if (roll > max) {
              max = roll;
            }
            roll_total += roll;
            results.push("d" + die_max + ": " + roll);
          }
          if (count > 1) {
            results.push("  group total: " + total + " average: " + (total / count) + " min: " + min + " max: " + max);
          } else {
            results.push(' ');
          }
        }
      }
      results.push("\nroll total: " + roll_total);
      return results.join("\n");
    }, 'roll some dice', {
      EXAMPLES: ['roll d20', 'roll 3d10', 'roll 5d2 d4 d13'],
      SYNTAX: 'a die is defined by "d" followed by a digit. you can roll the same die multipe times by preceeding the die with the number of times to roll',
      TODO: 'currently roll with out any arguments blows up, should give you the help text or at least tell you why you got nothing'
    }
  ],
  barrel: [
    function(type) {
      if (type === 'roll') {
        $('#terminal').addClass('barrel_roll');
        return setTimeout("$('#terminal').removeClass('barrel_roll')", 4200);
      }
    }
  ],
  flip: [
    function() {
      if (getRandomInt(0, 1)) {
        return 'heads';
      } else {
        return 'tails';
      }
    }, 'flip a coin'
  ],
  yn: [
    function() {
      if (getRandomInt(0, 1)) {
        return 'yes';
      } else {
        return 'no';
      }
    }, 'random yes or no'
  ],
  reload: [
    function() {
      return window.location.reload();
    }, 'reload the term'
  ],
  repeat: [
    function(url) {
      return ' just go to http://notbenh.info/repeater.php as this is not yet done';
    }, 'take a URL and build single page with said URL repeated as a background'
  ],
  color: [
    function(colors) {
      var a, a2b, b, b_diff, c, g_diff, i, one, parsed_colors, r_diff, rehex, results, row, row_swatches, step, swatch, three, two, unhex, _i, _j, _k, _l;
      parsed_colors = colors.split(/\s+/);
      one = parsed_colors[0];
      two = parsed_colors[1];
      three = parsed_colors[2];
      if (two === void 0) {
        throw "color requires at least two colors";
      }
      swatch = function(c) {
        return "[[;;#" + c + ";swatch]#" + c + "     ]";
      };
      unhex = function(c) {
        var rgb;
        if (c.length === 3) {
          rgb = /(.)(.)(.)/.exec(c);
          return [parseInt(''.concat(rgb[1], rgb[1]), 16), parseInt(''.concat(rgb[2], rgb[2]), 16), parseInt(''.concat(rgb[3], rgb[3]), 16)];
        } else {
          rgb = /(..)(..)(..)/.exec(c);
          return [parseInt(rgb[1], 16), parseInt(rgb[2], 16), parseInt(rgb[3], 16)];
        }
      };
      rehex = function(r, g, b) {
        return ''.concat(('00' + parseInt(r).toString(16)).substr(-2), ('00' + parseInt(g).toString(16)).substr(-2), ('00' + parseInt(b).toString(16)).substr(-2));
      };
      step = 10;
      a = unhex(one);
      b = unhex(two);
      r_diff = (a[0] - b[0]) / step;
      g_diff = (a[1] - b[1]) / step;
      b_diff = (a[2] - b[2]) / step;
      results = [];
      a2b = [];
      for (i = _i = 0; 0 <= step ? _i <= step : _i >= step; i = 0 <= step ? ++_i : --_i) {
        a2b.push([a[0] - (i * r_diff), a[1] - (i * g_diff), a[2] - (i * b_diff)]);
      }
      if (three !== void 0) {
        c = unhex(three);
        for (row = _j = 0; 0 <= step ? _j <= step : _j >= step; row = 0 <= step ? ++_j : --_j) {
          r_diff = (c[0] - a2b[row][0]) / step;
          g_diff = (c[1] - a2b[row][1]) / step;
          b_diff = (c[2] - a2b[row][2]) / step;
          row_swatches = [];
          for (i = _k = 0; 0 <= step ? _k <= step : _k >= step; i = 0 <= step ? ++_k : --_k) {
            row_swatches.push(swatch(rehex(c[0] - (i * r_diff), c[1] - (i * g_diff), c[2] - (i * b_diff))));
          }
          results.push(row_swatches.reverse().join(''));
        }
      } else {
        for (i = _l = 0; 0 <= step ? _l <= step : _l >= step; i = 0 <= step ? ++_l : --_l) {
          results.push(swatch(rehex(a2b[i][0], a2b[i][1], a2b[i][2])));
        }
      }
      return results.join("\n");
    }, 'build a graident between two or three html/hex colors', {
      EXAMPLES: ['color FFF 000', 'color 012345 FEDCBA', 'color 012345 FEDCBA CCC']
    }
  ]
};
