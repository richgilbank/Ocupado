'use strict';
var LIVERELOAD_PORT = 35729;
var SERVER_PORT = 9000;
var lrSnippet = require('connect-livereload')({port: LIVERELOAD_PORT});
var mountFolder = function (connect, dir) {
  return connect.static(require('path').resolve(dir));
};

module.exports = function (grunt) {
  // show elapsed time at the end
  require('time-grunt')(grunt);
  // load all grunt tasks
  require('load-grunt-tasks')(grunt);

  // configurable paths
  var yeomanConfig = {
    app: 'app',
    dist: 'dist'
  };

  grunt.initConfig({
    yeoman: yeomanConfig,
    watch: {
      options: {
        nospawn: true,
        livereload: true
      },
      coffee: {
        files: ['<%= yeoman.app %>/scripts/{,*/}*.coffee'],
        tasks: ['coffee:dist']
      },
      livereload: {
        options: {
          livereload: LIVERELOAD_PORT
        },
        files: [
          '<%= yeoman.app %>/*.html',
          '{.tmp,<%= yeoman.app %>}/styles/{,*/}*.css',
          '{.tmp,<%= yeoman.app %>}/styles/{,*/}*.styl',
          '{.tmp,<%= yeoman.app %>}/scripts/{,*/}*.js',
          '<%= yeoman.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp}',
          '<%= yeoman.app %>/scripts/templates/*.{ejs,mustache,hbs}',
          'test/spec/**/*.js'
        ]
      },
      jst: {
        files: [
          '<%= yeoman.app %>/scripts/templates/*.hbs'
        ],
        tasks: ['handlebars']
      },
      test: {
        options: {
          livereload: 35728
        },
        files: ['.tmp/**/*.js', 'test/**/*.coffee'],
        tasks: ['coffee:test', 'mocha']
      },
      stylus: {
        files: [
          '<%= yeoman.app %>/styles/**/*.styl'
        ],
        tasks: ['stylus']
      }
    },
    connect: {
      options: {
        port: SERVER_PORT,
        // change this to '0.0.0.0' to access the server from outside
        hostname: '0.0.0.0'
      },
      livereload: {
        options: {
          middleware: function (connect) {
            return [
              lrSnippet,
              mountFolder(connect, '.tmp'),
              mountFolder(connect, yeomanConfig.app)
            ];
          }
        }
      },
      test: {
        options: {
          port: 9001,
          middleware: function (connect) {
            return [
              lrSnippet,
              mountFolder(connect, '.tmp'),
              mountFolder(connect, '.'),
              mountFolder(connect, yeomanConfig.app)
            ];
          }
        }
      },
      dist: {
        options: {
          middleware: function (connect) {
            return [
              mountFolder(connect, yeomanConfig.dist)
            ];
          }
        }
      }
    },
    clean: {
      dist: ['.tmp', '<%= yeoman.dist %>/*'],
      server: '.tmp'
    },
    jshint: {
      options: {
        jshintrc: '.jshintrc',
        reporter: require('jshint-stylish')
      },
      all: [
        'Gruntfile.js',
        '<%= yeoman.app %>/scripts/{,*/}*.js',
        '!<%= yeoman.app %>/scripts/vendor/*'
        // 'test/spec/{,*/}*.js'
      ]
    },
    mocha: {
      all: {
        options: {
          run: true,
          urls: ['http://localhost:<%= connect.test.options.port %>/test/index.html'],
          timeout: 5000,
          bail: false
        }
      }
    },
    coffee: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/scripts',
          src: '{,*/}*.coffee',
          dest: '.tmp/scripts',
          ext: '.js'
        }]
      },
      test: {
        options: {
          bare: true
        },
        files: {
          'test/spec/test.js': 'test/**/*.coffee',
          'test/spec/main.js': 'app/scripts/main.coffee',
          'test/spec/app.js': [
            '!app/scripts/main.coffee',
            'app/scripts/lib/*.coffee',
            'app/scripts/views/*.coffee',
            'app/scripts/models/*.coffee',
            'app/scripts/collections/*.coffee'
           ]
         }
      }
    },
    stylus: {
      compile: {
        options: {
          paths: [
            '<%= yeoman.app %>/styles/includes',
            '<%= yeoman.app %>/styles/rooms'
          ]
        },
        files: {
          '<%= yeoman.app %>/styles/main.css': ['<%= yeoman.app %>/styles/main.styl']
        }
      }
    },
    useminPrepare: {
      html: '<%= yeoman.app %>/index.html',
      options: {
        dest: '<%= yeoman.dist %>'
      }
    },
    usemin: {
      html: ['<%= yeoman.dist %>/{,*/}*.html'],
      css: ['<%= yeoman.dist %>/styles/{,*/}*.css'],
      options: {
        dirs: ['<%= yeoman.dist %>']
      }
    },
    uglify: {
      dist: {
        options: {
          banner: "window._ENV='production';"
        },
        files: {
          'dist/scripts/main.js': ['dist/scripts/main.js']
        }
      }
    },
    imagemin: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>/images',
          src: '{,*/}*.{png,jpg,jpeg}',
          dest: '<%= yeoman.dist %>/images'
        }]
      }
    },
    htmlmin: {
      dist: {
        options: {
          /*removeCommentsFromCDATA: true,
          // https://github.com/yeoman/grunt-usemin/issues/44
          //collapseWhitespace: true,
          collapseBooleanAttributes: true,
          removeAttributeQuotes: true,
          removeRedundantAttributes: true,
          useShortDoctype: true,
          removeEmptyAttributes: true,
          removeOptionalTags: true*/
        },
        files: [{
          expand: true,
          cwd: '<%= yeoman.app %>',
          src: '*.html',
          dest: '<%= yeoman.dist %>'
        }]
      }
    },
    copy: {
      dist: {
        files: [{
          expand: true,
          dot: true,
          cwd: '<%= yeoman.app %>',
          dest: '<%= yeoman.dist %>',
          src: [
            '*.{ico,txt}',
            '.htaccess',
            'images/{,*/}*.{webp,gif}',
            'fonts/{,*/}*.*',
          ]
        }]
      }
    },
    handlebars: {
      compile: {
        files: {
          '.tmp/scripts/templates.js': ['app/scripts/**/*.hbs']
        },
        options: {
          namespace: 'Ocupado.Templates',
          wrapped: true,
          partialsUseNamespace: true
        }
      },
      test: {
        files: {
          'test/spec/templates.js': ['app/scripts/**/*.hbs']
        },
        options: {
          namespace: 'Ocupado.Templates',
          wrapped: true,
          partialsUseNamespace: true
        }
      }
    },
    rev: {
      dist: {
        files: {
          src: [
            '<%= yeoman.dist %>/scripts/{,*/}*.js',
            '<%= yeoman.dist %>/styles/{,*/}*.css',
            '<%= yeoman.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp}',
            '/styles/fonts/{,*/}*.*',
          ]
        }
      }
    }
  });

  grunt.registerTask('server', function (target) {
    if (target === 'dist') {
      return grunt.task.run(['build', 'connect:dist:keepalive']);
    }

    if (target === 'test') {
      return grunt.task.run([
        'clean:server',
        'coffee',
        'handlebars',
        'watch:livereload'
      ]);
    }

    grunt.task.run([
      'clean:server',
      'coffee:dist',
      'stylus:compile',
      'handlebars',
      'connect:livereload',
      'watch'
      // 'watch:coffee',
      // 'watch:livereload',
      // 'watch:jst',
      // 'watch:stylus'
    ]);

  });

  grunt.registerTask('test', function(){
    grunt.task.run([
      'clean:server',
      'coffee:test',
      'handlebars:test',
      'connect:test',
      'mocha',
      'watch:test'
    ]);
  });

  grunt.registerTask('build', [
    'clean:dist',
    'coffee',
    'jshint',
    'handlebars',
    'useminPrepare',
    'imagemin',
    'htmlmin',
    'concat',
    'stylus:compile',
    'uglify:dist',
    'copy',
    'rev',
    'usemin'
  ]);

  grunt.registerTask('default', [
    'jshint',
    'test',
    'build'
  ]);
};

