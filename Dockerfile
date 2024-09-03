FROM ubuntu:24.04 AS extract
COPY dist/mattermost-team-linux-amd64.tar.gz /
COPY config.json /
RUN tar -xzf /mattermost-team-linux-amd64.tar.gz -C /

FROM ubuntu:24.04
COPY --from=extract /mattermost /mattermost
COPY --from=extract /config.json /mattermost/config/config.json
ENTRYPOINT ["/mattermost/bin/mattermost"]
