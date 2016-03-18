use iron::{Handler, Request, Response, IronResult, status};
use mount::Mount;

pub use self::dropbox::Dropbox;
pub use self::fs::Fs;


pub struct Providers {
    mount: Mount,
}


impl Providers {
    pub fn new() -> Providers {
        let mut mount = Mount::new();

        mount.mount("/dropbox", Dropbox);
        mount.mount("/fs", Fs);

        Providers { mount: mount }
    }
}

impl Handler for Providers {
    fn handle(&self, req: &mut Request) -> IronResult<Response> {
        self.mount.handle(req)
    }
}


mod fs;
mod dropbox;