require("harpoon").setup({
    projects = {
        ["/Users/wuilliam.lacruz/p/capijzo-extension"] = {
            term = {
                cmds = {
                    "yarn test\n",
                    "yarn start\n",
                }
            }
        },
        ["/Users/wuilliam.lacruz/w/partner-portal-web"] = {
            term = {
                cmds = {
                    "npm run unit\n",
                    "nvm use 10.16.3 && npm run local\n"
                }
            }
        },
        ["/Users/wuilliam.lacruz/go/src/github.com/pedidosya/items-management-service"] = {
            term = {
                cmds = {
                    "make test\n",
                    "make web\n"
                }
            }
        },
        ["/Users/wuilliam.lacruz/go/src/github.com/pedidosya/vp-users-management-service"] = {
            term = {
                cmds = {
                    "make test\n",
                    "make web\n"
                }
            }
        },
        ["/Users/wuilliam.lacruz/go/src/github.com/pedidosya/vendor-portal-ssu-service"] = {
            term = {
                cmds = {
                    "make test\n",
                    "make web\n"
                }
            }
        }
    }
})
