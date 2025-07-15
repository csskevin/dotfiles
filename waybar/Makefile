.PHONY: all 

all:
	rm config
	echo "[" >> config
	sed -e "s|#OUTPUT|\"eDP-1\"|g" \
			-e "s|#REGULAR|//|g" \
			-e "s|#COMPACT||g" \
			config.template >> config
	echo "," >> config	
	sed -e "s|#OUTPUT|[\"HDMI-A-1\", \"HDMI-A-2\", \"DP-1\"]|g" \
			-e "s|#REGULAR||g" \
			-e "s|#COMPACT|//|g" \
			config.template >> config
	echo "]" >> config
