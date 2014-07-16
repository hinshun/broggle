function highlight(string) {
  return '<span class="highlight">' + string + '</span>';
}

function flexHighlight(string, query) {
    var tokens = query.toLowerCase().split(''),
        matches = [];

    var tokenIndex = 0,
        stringIndex = 0,
        highlightedString = '',
    
    string = string.toLowerCase();
    
    while (stringIndex < string.length) {
        if (string[stringIndex] === tokens[tokenIndex]) {
            highlightedString += highlight(string[stringIndex]);
            tokenIndex++;
            
            if (tokenIndex >= tokens.length) {
                highlightedString += string.slice(stringIndex + 1)
                break;
            }
        }
        else {
            highlightedString += string[stringIndex];
        }
        
        stringIndex++;
    }
    return highlightedString
}

$(function() {
  var currentQuery;

  $('#select-base').selectize({
    valueField: 'name',
    labelField: 'name',
    searchField: 'name',
    sortField: 'score',
    openOnFocus: false,
    highlight: false,
    score: function(search) {
      return function(item) {
        return item.score;
      };
    },
    render: {
      option: function(item, escape) {
        return '<div>' +
          '<span class="name">' + flexHighlight(escape(item.name), currentQuery) + '</span>' +
        '</div>';
      }
    },
    load: function(query, callback) {
      if (!query.length) return callback();
      currentQuery = query;
      this.clearOptions();
      $.ajax({
        url: 'broggle/search/' + encodeURIComponent(query),
        type: 'GET',
        error: function() {
          callback();
        },
        success: function(res) {
          callback(res);
        }
      });
    }
  });

  $('#select-branches').selectize({
    valueField: 'name',
    labelField: 'name',
    searchField: 'name',
    openOnFocus: false,
    render: {
      option: function(item, escape) {
        return '<div>' +
          '<span class="name">' + escape(item.name) + '</span>' +
        '</div>';
      }
    },
    load: function(query, callback) {
      if (!query.length) return callback();
      $.ajax({
          url: 'broggle/search/' + encodeURIComponent(query),
          type: 'GET',
          error: function() {
              callback();
          },
          success: function(res) {
              callback(res);
          }
      });
    }
  });

  $('#select-repo').selectize({
      valueField: 'url',
      labelField: 'name',
      searchField: 'name',
      create: false,
      render: {
          option: function(item, escape) {
              return '<div>' +
                  '<span class="title">' +
                      '<span class="name"><i class="icon ' + (item.fork ? 'fork' : 'source') + '"></i>' + escape(item.name) + '</span>' +
                      '<span class="by">' + escape(item.username) + '</span>' +
                  '</span>' +
                  '<span class="description">' + escape(item.description) + '</span>' +
                  '<ul class="meta">' +
                      (item.language ? '<li class="language">' + escape(item.language) + '</li>' : '') +
                      '<li class="watchers"><span>' + escape(item.watchers) + '</span> watchers</li>' +
                      '<li class="forks"><span>' + escape(item.forks) + '</span> forks</li>' +
                  '</ul>' +
              '</div>';
          }
      },
      score: function(search) {
          var score = this.getScoreFunction(search);
          return function(item) {
              return score(item) * (1 + Math.min(item.watchers / 100, 1));
          };
      },
      load: function(query, callback) {
          if (!query.length) return callback();
          $.ajax({
              url: 'https://api.github.com/legacy/repos/search/' + encodeURIComponent(query),
              type: 'GET',
              error: function() {
                  callback();
              },
              success: function(res) {
                  callback(res.repositories.slice(0, 10));
              }
          });
      }
  });
});
