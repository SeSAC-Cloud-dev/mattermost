FROM ubuntu:24.04 AS extract
COPY server/dist/mattermost-team-linux-amd64.tar.gz /
RUN tar -xzf /mattermost-team-linux-amd64.tar.gz -C /

FROM ubuntu:24.04
COPY --from=extract /mattermost /mattermost
CMD ["/mattermost/config/config.json"]
ENTRYPOINT ["/mattermost/bin/mattermost", "-c"]
