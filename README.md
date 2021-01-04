# check_pacman
check_pacman is a bash script for monitoring available package updates and security issues via [arch-audit](https://github.com/ilpianista/arch-audit)

## Installation

Clone via 
```bash
git clone https://github.com/schimper/monitoring-plugins ${MONITORING_PLUGINS_DIR}
```
 to install check_pacman.



## Usage

```
check_pacman - Check for Software Updates & Security via pacman and arch-audit
Syntax: check_pacman [-h|-w|-c|-i]
options:
     -h     Print this Help.
     -w     Value for Warn if #Updates >= w (DEFAULT=5)
     -c     Value for Crit if #Updates >= c (DEFAULT=10)
     -i     Flag to disable the usage of arch-audit

```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[GPLv3](https://www.gnu.org/licenses/gpl-3.0.de.html)
