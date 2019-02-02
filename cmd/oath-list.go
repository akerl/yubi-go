package cmd

import (
	"fmt"

	"github.com/akerl/yubi-go/modes/oath"

	"github.com/spf13/cobra"
)

func oathListRunner(_ *cobra.Command, _ []string) error {
	o, err := oath.NewClient()
	if err != nil {
		return err
	}

	l, err := o.List()
	if err != nil {
		return nil
	}

	for _, i := range l {
		fmt.Println(i.Name)
	}
	return nil
}

var oathListCmd = &cobra.Command{
	Use:   "list",
	Short: "List OATH credentials",
	RunE:  oathListRunner,
}

func init() {
	oathCmd.AddCommand(oathListCmd)
}
