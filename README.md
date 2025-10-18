# CodeAlpha_NIDS
A minimal, Windows-first Network Intrusion Detection System (NIDS) using Snort 2.x and Npcap. This repo helps you install, configure, run, test, and troubleshoot Snort on Windows with a clean config and a few sample rules.
**FEATURES**
Minimal snort.conf tailored for Windows
Clean local.rules with safe starter rules
One-liner run script for validation and live monitoring
Step-by-step test instructions (e.g., detect pings)
Practical troubleshooting for common Windows errors
**REQUIREMENTS**
Windows 10/11 (Admin privileges)
Npcap (install in WinPcap-compatible mode)
Snort 2.x for Windows
**REPOSITORY LAYOUT**
.
├── configs/
│   └── snort.conf            # Minimal, Windows-friendly config
├── rules/
│   └── local.rules           # Your rules live here
├── scripts/
│   └── run_snort.bat         # Validate + run Snort
└── README.md
**QUICK START**
Install Npcap
Choose: “Install Npcap in WinPcap API-compatible mode.”
Install Snort
Default path (examples below assume): C:\Snort
Create log folder: mkdir C:\Snort\log
Copy repo files into: 
C:\Snort\etc\        -> configs\snort.conf
C:\Snort\rules\      -> rules\local.rules
C:\Snort\scripts\    -> scripts\run_snort.bat
Open an elevated Command Prompt (Run as Administrator).
Validate config: snort -T -c C:\Snort\etc\snort.conf -l C:\Snort\log
You want: “Snort successfully validated the configuration!”
Run Snort (IDS mode)
Find your interface number first: snort -W
Then run (replace 2 with your interface #): snort -A console -i 2 -c C:\Snort\etc\snort.conf -l C:\Snort\log -K ascii
Generate test traffic: ping 8.8.8.8
See alerts
In the Snort console (live)
In C:\Snort\log\alert.fast
**CONFIGURATION**
configs/snort.conf (Windows-first)
Uses Windows paths only (no Linux /usr/local/...)
Loads dynamic preprocessors & engine from C:\Snort\lib\...
Uses a simple, valid HTTP Inspect config (Snort 2.x)
Only includes your local rules by default
Writes logs to C:\Snort\log (text alerts with -K ascii)
rules/local.rules
Starter rules, including an ICMP (ping) alert to verify everything works.
TROUBLESHOOTING

| Error / Symptom                               | Likely Cause                      | Fix                                                                                                                                                  |
| --------------------------------------------- | --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Var 'RULE_PATH' redefined`                   | `RULE_PATH` set twice             | Keep **one** line: `var RULE_PATH "C:\Snort\rules"`                                                                                                  |
| Paths like `/usr/local/lib/...`               | Linux defaults in config          | Use Windows paths from `configs/snort.conf`                                                                                                          |
| `Could not stat dynamic module path`          | Wrong preprocessor/engine paths   | Ensure: `C:\Snort\lib\snort_dynamicpreprocessor` and `C:\Snort\lib\snort_dynamicengine\sf_engine.dll` exist; correct if Snort is installed elsewhere |
| Dynamic rules dir missing                     | Folder not present by default     | Comment out `dynamicdetection directory ...` or create `C:\Snort\lib\snort_dynamicrules`                                                             |
| Double quotes in error (`""C:\Snort\lib..."`) | Extra quotes in conf              | Ensure **single** pair of quotes                                                                                                                     |
| `Invalid keyword 'inspection_type'`           | Option not supported in Snort 2.x | Use the HTTP Inspect block provided here                                                                                                             |
| `Failed to open log file log/...`             | Relative path or permission issue | Create `C:\Snort\log`, run as Admin, use `-l C:\Snort\log` and `-K ascii`                                                                            |
| No alerts appear                              | Wrong interface, rules not loaded | Check `snort -W`, confirm `include $RULE_PATH/local.rules`, and generate test traffic (e.g., `ping`)                                                 |
