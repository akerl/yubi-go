package oath

// Entry is a single OATH credential
type Entry struct {
	Name string
}

// List is a collection of Entries
type List []Entry

// Client is the OATH connection to a Yubikey
type Client struct {
}

// NewClient provides a new Client object
func NewClient() (Client, error) {
	return Client{}, nil
}

// List returns the available Entries
func (c Client) List() (List, error) {
	var l List
	e := Entry{
		Name: "bar",
	}
	l = append(l, e)
	return l, nil
}
