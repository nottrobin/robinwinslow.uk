require 'rack'
require 'rack/rewrite'
require 'rack/contrib/try_static'

# Enable compression
use Rack::Deflater

# Rewrites
# ---
use Rack::Rewrite do
    # Remove HTML extensions
    r301 %r{^/(\w+).html$},     '/$1'

    # Make sure index.html => /
    r301 %r{^/index(.html)?$},  '/'

    # Static rewrites
    r301 '/2011/04/06/php-csv-import-script/',  '/2012/03/13/importing-a-csv-file-into-mysql'
    r301 '/tagged/brain-dump',                  '/postsbytag.html#personal'
    r301 '/2011/07/25/css-good-practice-tips/', '/2012/03/13/css-best-practice-tips'
    r301 '/tagged/front-end',                   '/postsbytag.html#front-end'
    r301 '/tagged/typeography',                 '/postsbytag.html#front-end'
    r301 '/tagged/tmux',                        '/postsbytag.html#unix'
    r301 '/tagged/open-access',                 '/postsbytag.html#politics'
    r301 '/page/2',                             '/'
    r301 '/2011/05/25/javascript-passing-an-object-context-to-a-callback-function/feed/', '/2012/03/13/javascript-closures-passing-an-object-context-to-a-callback-function'

    # Regex rewrites
    r301 %r{^/post/40771096073},    '/2013/01/18/where-do-i-sign-up-for-the-open-access-movement'
    r301 %r{^/post/37846002351},    '/2012/12/13/oss-projects-i-d-love-to-get-involved-with'
    r301 %r{^/post/37785959903},    '/2012/12/12/note-to-self-technical-aspirations'
    r301 %r{^/post/37413262948},    '/2012/12/07/continuous-improvement-and-tdd-bdd'
    r301 %r{^/post/37412613737},    '/2012/12/07/a-blogs-existential-quest'
    r301 %r{^/post/37117413644},    '/2012/12/03/an-open-letter-to-avaaz'
    r301 %r{^/post/35858211521},    '/2012/11/16/sass-just-became-feasible'
    r301 %r{^/post/32940333839},    '/2012/10/05/what-to-do-if-your-vagrant-vm-crashes'
    r301 %r{^/post/32454555914},    '/2012/09/28/i-am-a-published-author-of-a-journal-article'
    r301 %r{^/post/28835090592},    '/2012/08/06/finding-a-free-version-of-gill-sans'
    r301 %r{^/post/27629547036},    '/2012/07/20/tmux-and-ssh-auto-login-with-ssh-agent-finally'
    r301 %r{^/post/27370485407},    '/2012/07/17/installing-vagrant-on-centos-the-more-reliable-way'
    r301 %r{^/post/27354548116},    '/2012/07/16/my-piratebay-mirror'
    r301 %r{^/post/27265158526},    '/2012/07/15/in-opposition-of-the-bankers-behind-bars-campaign'
    r301 %r{^/post/20811491590},    '/2012/04/10/learning-to-scale-svg-icons'
    r301 %r{^/post/20809514118},    '/2012/04/10/sending-emails-individually-to-many-people-in-php'
    r301 %r{^/post/19246584777},    '/2012/03/13/website-front-end-performance-tips'
    r301 %r{^/post/19246455152},    '/2012/03/13/css-best-practice-tips'
    r301 %r{^/post/19246171971},    '/2012/03/13/javascript-closures-passing-an-object-context-to-a-callback-function'
    r301 %r{^/post/19244584389},    '/2012/03/13/importing-a-csv-file-into-mysql'
    r301 %r{^/post/19244149331},    '/2012/03/13/blog-ideas'
    r301 %r{^/post/19243192502},    '/2012/03/13/usable-layout-responsive-design'
    r301 %r{^/post/40557407998},    '/2013/01/18/where-do-i-sign-up-for-the-open-access-movement'
    r301 %r{^/post/29652660939},     '/2012/08/06/finding-a-free-version-of-gill-sans'
end

# Serve files
# ---
use Rack::TryStatic,
    :root         => '_site',       # Serve files from _site folder
    :urls         => %w[/],         # match all requests
    :index        => 'index.html',  # index.html is index (/)
    :try          => ['.html'],     # try adding .html
    :header_rules => [
        [['html'],      {'Content-Type' => 'text/html; charset=utf-8'}], # Specify encoding for HTML 
        # Cache CSS and JS for a year
        [['css'], {
            'Content-Type' => 'text/css; charset=utf-8',
            'Cache-Control' => 'public, max-age=29030400'}
        ],
        [['js'], {
            'Content-Type' => 'text/javascript; charset=utf-8',
            'Cache-Control' => 'public, max-age=29030400'}
        ],
    ]

# Deleted or not found
# ---
run lambda { |env|
    request = Rack::Request.new(env)
    headers = { 'Content-Type' => 'text/html' }

    deleted = [
        '/post/37901151578/open-letter-thank-you-wired-re-adverts',
        '/disable_mobile_interface',
        '/2011/05/02/68-revision-8/',
        '/2011/05/02/68-revision-5/',
        '/2011/05/02/68-revision-9/',
        '/2011/05/02/68-revision-18/',
        '/2011/05/02/68-revision-16/',
        '/2011/05/02/68-revision-13/',
        '/2011/05/02/68-revision-14/',
        '/2011/05/02/68-revision-11/',
        '/2011/05/02/68-revision-12/',
        '/2011/04/19/64-revision/',
        '/2011/04/06/58-revision/',
        '/2011/05/02/68-revision-2/',
        '/2011/04/06/44-revision-6/',
        '/2011/04/06/44-revision-11/',
        '/2011/04/06/44-revision-12/',
        '/2011/04/06/44-autosave/',
        '/2011/03/31/43-revision/',
        '/2011/04/06/44-revision-2/',
        '/2011/05/02/68-revision-3/',
        '/2011/05/02/68-revision-6/',
        '/2011/05/02/68-revision-10/',
        '/2011/05/02/68-revision/',
        '/2011/05/02/68-revision-7/',
        '/2011/05/02/68-revision-4/',
        '/2011/05/02/68-revision-15/',
        '/2011/05/02/68-revision-17/',
        '/2011/04/07/61-revision/',
        '/2011/04/06/44-revision/',
        '/2011/04/06/44-revision-9/',
        '/2011/04/06/44-revision-8/',
        '/2011/04/06/44-revision-7/',
        '/2011/04/06/44-revision-5/',
        '/2011/04/06/44-revision-4/',
        '/2011/04/06/44-revision-3/',
        '/2011/04/06/44-revision-10/',
        '/2010/11/21/41-revision/'
    ]

    if deleted.include? request.path
        # File deleted
        # ---
        [410, {'Content-Type' => 'text/html'}, File.open('_site/410.html', File::RDONLY)]
    else
        # File not found
        # ---
        [404, {'Content-Type' => 'text/html'}, File.open('_site/404.html', File::RDONLY)]
    end
}
