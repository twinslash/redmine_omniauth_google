## Redmine omniauth google

This plugin is used to authenticate in redmine through Google.

### Installation:

Choose folder /plugins, make command

```console
git clone https://github.com/twinslash/redmine_omniauth_google.git
```

Update gems and restart rails server.

### Registration

To make possible to authenticate via Google you must first to register application in Google

* Go to the [registration](https://code.google.com/apis/console) link.
* Press "API Access" in left menu bar.
* Click the button "Create an OAuth 2.0 client ID".
* When registering specify application name, for example, Redmine Oauth Google.
* In section "Your site or hostname" choose mode http, in the text input box enter your domain. For example: www.example.com or localhost
* Press the button "Create client ID".

The registrations is complete.

### Configuration

To make plugin to work properly

* Login as administrator. In top menu select "Administration". Choose menu item Plugins. In plugins list choose "Redmine Omniauth Google plugin". Press "Configure".
* Fill Сlient ID & Client Secret by corresponding values, obtained by Google.
* Put the check "Oauth authentification", to make it possible to login through Google. Click Apply. Users can now to use apportunity to login via Google.

Additionaly
* Setup value Autologin in Settings on tab Authentification

### Other options

By default, all domains are allowed to authenticate through Google.
To limit login through Google for other domains you have to fill allowed domains in the text box field the "Allowed domains". Domains must be separated by newlines. For example:

```text
onedomain.com
otherdomain.com
```

### Work process

User goes to the login page (sign in) and clicks the button with Google image. The plugin redirects him to Google where user enters his the еmail & password from Google. Google redirects user back to plugins controller. Then the following cases:
1. If auto registration is enabled, user is redirected to 'my/page'
2. In other case user account is created and waited for admin activation
