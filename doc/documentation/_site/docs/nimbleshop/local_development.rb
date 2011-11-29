<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en-us">
<head>
  <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
  <meta http-equiv="Cache-control" content="no-cache" />
  <meta http-equiv="Pragma" content="no-cache" />
  <title>BigBinary - Setting up local development environment</title>

  <meta name="description" content="credit card processing" />

  <link rel="stylesheet" href="/css/reset.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="/css/text.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="/css/960.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="/css/screen.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="/css/syntax.css" type="text/css" media="screen" />
</head>

<body>

  <div id="header" class="container_12 clearfix">
    <div id="logo">
      <div><a href="/">Documentation</a></div>
    </div>
    <div id="navigation">
      <ul id="nav">
        <li><a href="/">nimbleSHOP</a></li>
      </ul>
    </div>
  </div>

  <div id="content" class="container_12 clearfix">
    <div class="grid_3 alpha sidebar">
      <div class="block">
        <ol>
          
            <li><a href="/docs/nimbleshop/index.html">Introduction</a></li>
          

          
            <li><a href="/docs/nimbleshop/features.html">Features</a></li>
          


          
            <li><a href='/docs/nimbleshop/local_development.html'>Setup local environment</a></li>
          


          
            <li><a href="/docs/nimbleshop/deployment.html">Deployment</a></li>
          

          
            <li><a href="/docs/credit-cards/merchant-account.html">Merchant Account</a></li>
          


          
            <li><a href="/docs/credit-cards/credit-card-processor.html">Credit card processor</a></li>
          

            <ul>
              
                <li><a href="/docs/credit-cards/fee.html">Fee</a></li>
              

              
                <li><a href="/docs/credit-cards/interchange-plus.html">Interchange plus</a></li>
              

              
                <li><a href="/docs/credit-cards/tiered.html">Tiered pricing</a></li>
              
            </ul>

          
            <li><a href="/docs/credit-cards/price_discrimination.html">Price discrimination</a></li>
          

          
            <li><a href="/docs/credit-cards/resellers.html">Resellers</a></li>
          

          
            <li><a href="/docs/credit-cards/chargeback.html">Chargeback</a></li>
          


          
            <li><a href="/docs/credit-cards/debit_cards.html">Debit cards</a></li>
          

          
            <li><a href="/docs/credit-cards/security.html">Security</a></li>
          




        </ol>
      </div>

      <div class="block warning">
  <p>
    This ebook is a product of
    <a href='http://BigBinary.com'>BigBinary</a>
    .
  </p>
</div>

    </div>
    <div class="grid_9 omega guide">
      # Setting up local development environment

    git clone ....
    cp config/database.yml.example config/database.yml
    bundle install
    bundle exec rake db:create
    bundle exec rake db:migrate
    bundle exec rake db:bootstrap

Start rails server

    rails server

Visit the application at http://localhost:3000 .

Visit the admin page at http://localhost:3000/admin . Default admin login email is _admin@example.com_.

      
      
      
    </div>
  </div>

  <div id="footer" class="container_12 clearfix">
    <div id="copy">
    </div>
  </div>

  <script type="text/javascript">
  var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
  document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
  </script>
  <script type="text/javascript">
  try {
  var pageTracker = _gat._getTracker("UA-xxxx");
  pageTracker._trackPageview();
  } catch(err) {}</script>
</body>
</html>

