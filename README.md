# breach-rip

breach-rip is a modified version of [breach-parse](https://github.com/hmaverickadams/breach-parse) by Heath Adams that runs significantly faster thanks to [ripgrep](https://github.com/BurntSushi/ripgrep) and outputs more information! 

breach-rip works best when ran against several databases. 

## Requirements

There are only two requirements to run breach-rip.. Ripgrep and a breach list. 

Install Ripgrep: `sudo apt-get install ripgrep`

## Usage
If you don't store breach lists in `/opt/breaches`, specify the location via the fourth argument: 
`breach-parse @[COMPANY].com [COMPANY].txt /home/kali/latestbreaches/`

I strongly recommend having your breach in the following format or the output may not be as expected: \
`USER:PASSWORD`

## Outputs
* Main output
* Emails
* Usernames
* Passwords/Hashes

## Additional Information 

A breached password list is available with the following magnet: \
`magnet:?xt=urn:btih:7ffbcd8cee06aba2ce6561688cf68ce2addca0a3&dn=BreachCompilation&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Ftracker.leechers-paradise.org%3A6969&tr=udp%3A%2F%2Ftracker.coppersurfer.tk%3A6969&tr=udp%3A%2F%2Fglotorrents.pw%3A6969&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337`
