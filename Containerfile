FROM docker.io/redhat/ubi8-minimal:latest
ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]
