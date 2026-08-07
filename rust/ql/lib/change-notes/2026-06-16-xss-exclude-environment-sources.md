---
category: minorAnalysis
---
* The cross-site scripting (XSS) query no longer treats environment variables (the `environment` threat model, e.g. `std::env::var`) as a taint source. These values are trusted deployment configuration set at startup rather than per-request attacker-controlled input, so excluding them removes a class of false positives.
