package cmd

import (
	"github.com/spf13/cobra"
)

var oathCmd = &cobra.Command{
	Use:   "oath",
	Short: "Interact with Yubikey in oath mode",
}

func init() {
	rootCmd.AddCommand(oathCmd)
}
