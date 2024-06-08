{ pkgs, inputs, ... }:
let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in
{
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        #  Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
      DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
      SearchBar = "unified"; # alternative: "separate"

      Preferences = {
        "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
        "extensions.pocket.enabled" = lock-false;
        "extensions.screenshots.disabled" = lock-true;
        "browser.topsites.contile.enabled" = lock-false;
        "browser.formfill.enable" = lock-false;
        "browser.search.suggest.enabled" = lock-false;
        "browser.search.suggest.enabled.private" = lock-false;
        "browser.urlbar.suggest.searches" = lock-false;
        "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
        "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
        #        "privacy.resistFingerprinting" = true;
        #        "privacy.resistFingerprinting.letterboxing" = true;
      };

      profiles.default.userChrome = "
                    * { 
                        box-shadow: none !important;
                        border: 0px solid !important;
                    }

                    #tabbrowser-tabs {
                        --user-tab-rounding: 8px;
                    }

                    .tab-background {
                        border-radius: var(--user-tab-rounding) var(--user-tab-rounding) 0px 0px !important; /* Connected */
                        margin-block: 1px 0 !important; /* Connected */
                    }
                    #scrollbutton-up, #scrollbutton-down { /* 6/10/2021 */
                        border-top-width: 1px !important;
                        border-bottom-width: 0 !important;
                    }

                    .tab-background:is([selected], [multiselected]):-moz-lwtheme {
                        --lwt-tabs-border-color: rgba(0, 0, 0, 0.5) !important;
                        border-bottom-color: transparent !important;
                    }
                    [brighttext='true'] .tab-background:is([selected], [multiselected]):-moz-lwtheme {
                        --lwt-tabs-border-color: rgba(255, 255, 255, 0.5) !important;
                        border-bottom-color: transparent !important;
                    }

                    /* Container color bar visibility */
                    .tabbrowser-tab[usercontextid] > .tab-stack > .tab-background > .tab-context-line {
                        margin: 0px max(calc(var(--user-tab-rounding) - 3px), 0px) !important;
                    }

                    #TabsToolbar, #tabbrowser-tabs {
                        --tab-min-height: 29px !important;
                    }
                    #main-window[sizemode='true'] #toolbar-menubar[autohide='true'] + #TabsToolbar, 
                    #main-window[sizemode='true'] #toolbar-menubar[autohide='true'] + #TabsToolbar #tabbrowser-tabs {
                        --tab-min-height: 30px !important;
                    }
                    #scrollbutton-up,
                    #scrollbutton-down {
                        border-top-width: 0 !important;
                        border-bottom-width: 0 !important;
                    }

                    #TabsToolbar, #TabsToolbar > hbox, #TabsToolbar-customization-target, #tabbrowser-arrowscrollbox  {
                        max-height: calc(var(--tab-min-height) + 1px) !important;
                    }
                    #TabsToolbar-customization-target toolbarbutton > .toolbarbutton-icon, 
                    #TabsToolbar-customization-target .toolbarbutton-text, 
                    #TabsToolbar-customization-target .toolbarbutton-badge-stack,
                    #scrollbutton-up,#scrollbutton-down {
                        padding-top: 7px !important;
                        padding-bottom: 6px !important;
                    }
                ";

      ExtensionSettings = with builtins;
        let
          extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        in
        listToAttrs [
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "keepassxc-browser" "keepassxc-browser@keepassxc.org")
        ];
      # To add additional extensions, find it on addons.mozilla.org, find
      # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
      # Then, download the XPI by filling it in to the install_url template, unzip it,
      # run `jq .browser_specific_settings.gecko.id manifest.json` or
      # `jq .applications.gecko.id manifest.json` to get the UUID
    };
  };
}
