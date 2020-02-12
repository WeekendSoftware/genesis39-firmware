# Package: net/safe-dns

This package configures dnsmasq to block access to adult websites.

The default settings are designed to be appropriate for most businesses and families.

Enabled and disable Safe DNS by editing /etc/config/safe-dns. To make
your changes active, run safe-dns-update.

- Default DNS Filter
    - CleanBrowsing.org Adult Filter
        -  https://cleanbrowsing.org/filters#adult
        - Blocks access to all adult, pornographic and explicit sites. It does not block proxy or VPNs, nor mixed-content sites. Sites like Reddit are allowed. Google and Bing are set to the Safe Mode. Malicious and Phishing domains are blocked.
- Alternate DNS Filters:
    - CleanBrowsing.org Family Filter
        -  https://cleanbrowsing.org/filters#family
        - Blocks access to all adult, pornographic and explicit sites. It also blocks proxy and VPN domains that are used to bypass the filters. Mixed content sites (like Reddit) are also blocked. Google, Bing and Youtube are set to the Safe Mode. Malicious and Phishing domains are blocked.
	- Cisco Family Shield
		- https://www.opendns.com/home-internet-security/
		- https://www.opendns.com/setupguide/#familyshield
		- FamilyShield will always block domains that are categorized in our system as: Tasteless, Proxy/Anonymizer, Sexuality and Pornography.
