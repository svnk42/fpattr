ARCH_FLAGS=-arch arm64 -arch armv7 -marm -march=armv7-a

fpattr: main.m
	clang \
		-Os -Wall -bind_at_load -fobjc-arc \
		$(ARCH_FLAGS) \
		-mios-version-min=8.0 \
		-isysroot `xcrun --sdk iphoneos9.3 --show-sdk-path` \
		-o fpattr main.m

clean:
	rm -f fpattr
